// Trazabilidad automatica centralizada (Indicadores 46, 49).
// Toda query/mutation pasa por conAuditoria: registra exito, error o denegacion.
const { getDb } = require("./db");
const { normalizarRol } = require("./roles");

// El schema de col_logs acepta SOLO object/null en datos_anteriores y
// datos_posteriores; un array de resultados no pasa la validacion. Se resume.
function auditable(valor) {
  if (valor === null || valor === undefined) return null;
  if (Array.isArray(valor)) return { total: valor.length, primeros: valor.slice(0, 3) };
  if (typeof valor === "object") return valor;
  return { valor: String(valor) };
}

async function registrar(ctx, entrada) {
  const registro = {
    fecha_hora: new Date(),
    operacion: entrada.operacion,
    usuario: String(ctx.user || "anonimo"),
    rol: normalizarRol(ctx.role),
    ip: String(ctx.ip || "0.0.0.0"),
    coleccion: entrada.coleccion,
    documento_id: String(entrada.documento_id || "-"),
    descripcion: String(entrada.descripcion || "").substring(0, 490),
    estado: entrada.estado || "exitoso",
    datos_anteriores: auditable(entrada.datos_anteriores),
    datos_posteriores: auditable(entrada.datos_posteriores)
  };
  // El driver serializa undefined como null; el schema no permite null aqui.
  // Por eso el campo se agrega SOLO cuando el header x-request-id vino presente.
  if (ctx.requestId) registro.correlation_id = String(ctx.requestId).substring(0, 80);
  try {
    await getDb().collection("col_logs").insertOne(registro);
  } catch (err) {
    // La auditoria nunca debe romper la respuesta, pero se reporta en consola.
    console.error("[audit] No se pudo registrar:",
      err.errInfo ? JSON.stringify(err.errInfo.details || err.errInfo) : err.message);
  }
  return registro;
}

async function conAuditoria(ctx, params, ejecutar) {
  const { operacion, coleccion, documento_id, descripcion, recurso } = params;
  const rol = normalizarRol(ctx.role);
  const permitido = require("./roles").autorizado(rol, operacion, recurso || coleccion);

  if (!permitido) {
    const mensaje = `Acceso DENEGADO: rol '${rol}' no tiene privilegio ${operacion} sobre '${recurso || coleccion}'`;
    await registrar(ctx, {
      operacion: operacion === "READ" ? "AUTH_DENIED" : operacion,
      coleccion: recurso || coleccion,
      documento_id: documento_id || "-",
      descripcion: mensaje,
      estado: "denegado"
    });
    const err = new Error(mensaje);
    err.extensions = { code: "FORBIDDEN", audit: "AUTH_DENIED" };
    throw err;
  }

  try {
    const datos_anteriores = params.datos_anteriores || null;
    const resultado = await ejecutar();
    await registrar(ctx, {
      operacion, coleccion, documento_id,
      descripcion: `${descripcion} [autorizado: ${rol}]`,
      estado: "exitoso",
      datos_anteriores,
      datos_posteriores: params.datos_posteriores !== undefined
        ? params.datos_posteriores
        : (resultado && typeof resultado === "object" ? resultado : null)
    });
    return resultado;
  } catch (err) {
    await registrar(ctx, {
      operacion, coleccion, documento_id,
      descripcion: `ERROR: ${err.message}`,
      estado: "error",
      datos_anteriores: params.datos_anteriores || null
    });
    throw err;
  }
}

module.exports = { registrar, conAuditoria };
