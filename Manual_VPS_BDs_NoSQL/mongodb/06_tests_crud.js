// =============================================================================
// UTXJ - Unidad 2 - Apartado F (Indicadores 43-49)
// 06_tests_crud.js - Pruebas automatizadas CRUD + autorizacion + auditoria real
// =============================================================================
// Ejecutable en initdb (sin auth) y manualmente despues del arranque (con auth):
//   mongosh "mongodb://<root>:<pwd>@5.183.9.45:40085/ecommerce_nosql?authSource=admin" --file 06_tests_crud.js
// Todos los intentos van en try/catch: NINGUN error de permisos aborta el arranque.
// col_logs se alimenta SOLO con operaciones ejecutadas aqui (nunca sembrado).
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");

const DB = "ecommerce_nosql";
const IP_PRUEBA = "127.0.0.1 (mongosh)";
let PASS = 0, FAIL = 0;

// Para probar denegaciones REALES hace falta una conexion NUEVA por rol:
// db.auth() no puede cambiar de usuario en una conexion ya autenticada como root.
// En el VPS se puede exportar MONGO_HOST=127.0.0.1:27017 (o host:puerto remoto).
function conectarComo(usuario, password) {
  const host = process.env.MONGO_HOST || "127.0.0.1:27017";
  const uri = "mongodb://" + encodeURIComponent(usuario) + ":" +
              encodeURIComponent(password) + "@" + host + "/" +
              DB + "?authSource=" + DB;
  try {
    const cliente = new Mongo(uri);
    return cliente.getDB(DB);
  } catch (e) {
    print("  [AUTH-CONNECT-ERROR] " + usuario + ": " + e.message);
    return null;
  }
}

function pwd(envName, placeholder) {
  return process.env[envName] || placeholder;
}

function tryAuth(user, pass) {
  try {
    const res = db.auth(user, pass);
    if (res === 1 || res === true) return true;
  } catch (e) {
    // Sin autenticacion (fase initdb) o credenciales distintas: se tolera.
  }
  return false;
}

function authComo(user, envName, placeholder, rol) {
  const ok = tryAuth(user, pwd(envName, placeholder));
  print("  [AUTH] " + user + " (" + rol + "): " + (ok ? "autenticado" : "modo initdb / sesion compartida"));
  return ok;
}

function authRoot() {
  const u = process.env.MONGO_INITDB_ROOT_USERNAME;
  const p = process.env.MONGO_INITDB_ROOT_PASSWORD;
  if (!u || !p) return false;
  // El root vive en admin, no en ecommerce_nosql.
  try {
    const res = db.getSiblingDB("admin").auth(u, p);
    return res === 1 || res === true;
  } catch (e) {
    return false;
  }
}

// Registro REAL de auditoria. Se usa el contexto autenticado vigente.
function registrar(operacion, usuario, rol, coleccion, documento_id, descripcion, estado, antes, despues) {
  const doc = {
    fecha_hora: new Date(),
    operacion: operacion,
    usuario: usuario,
    rol: rol,
    ip: IP_PRUEBA,
    coleccion: coleccion,
    documento_id: String(documento_id),
    descripcion: descripcion,
    estado: estado,
    datos_anteriores: antes || null,
    datos_posteriores: despues || null,
    correlation_id: "PRUEBA_U2_" + Date.now()
  };
  try {
    db.col_logs.insertOne(doc);
    print("    [LOG] " + operacion + " / " + estado + " / " + coleccion + " / " + documento_id);
  } catch (e) {
    print("    [LOG-NO-DISPONIBLE] " + e.message);
  }
}

function verificar(nombre, condicion, detalle) {
  if (condicion) { PASS++; print("  [PASS] " + nombre); }
  else { FAIL++; print("  [FAIL] " + nombre + " :: " + (detalle || "")); }
}

function intentarDenegado(nombre, usuario, rol, fn) {
  const sufijo = rol.toUpperCase().replace("-", "_");
  const password = pwd("MONGO_USR_" + sufijo + "_PASSWORD", "CAMBIAR_CLAVE_" + sufijo);
  let denegado = false;
  let otroError = false;
  let mensaje = "";

  if (authActiva) {
    // Conexion NUEVA autenticada como el rol que se esta probando.
    const bdRol = conectarComo(usuario, password);
    if (!bdRol) {
      verificar(nombre, false, "No se pudo abrir la conexion del rol " + rol);
      return;
    }
    try {
      fn(bdRol);
    } catch (err) {
      mensaje = err.message || String(err);
      denegado = /not authorized|unauthorized|privilege|permission/i.test(mensaje);
      otroError = !denegado;
    }
  } else {
    // initdb: access control desactivado; se ejecuta sobre la sesion compartida
    // con filtros inofensivos y NO se cuenta como PASS/FAIL de autorizacion.
    print("  [INFO] " + nombre + ": modo initdb sin auth; la denegacion se valida al repetir contra el VPS.");
    try {
      fn(db);
    } catch (err) {
      mensaje = err.message || String(err);
      denegado = /not authorized|unauthorized|privilege|permission/i.test(mensaje);
    }
  }

  // La evidencia se escribe con la conexion root (o la sesion initdb).
  authRoot();
  registrar("AUTH_DENIED", usuario, rol, "seguridad", nombre,
    denegado ? ("Acceso rechazado: " + mensaje.substring(0, 180)) :
               (authActiva ? ("Error inesperado: " + mensaje.substring(0, 180)) :
                             "Intento ejecutado sin autenticacion activa (initdb): " +
                             (mensaje || "sin restriccion").substring(0, 140)),
    denegado ? "denegado" : "error", null, null);
  if (authActiva) {
    verificar(nombre, denegado, "Se esperaba error de privilegios; otroError=" + otroError + " :: " + mensaje);
  }
}

print("=============================================================");
print(" FASE F - PRUEBAS CRUD Y SEGURIDAD (Indicadores 43-49)");
print("=============================================================");

// Deteccion de modo: con auth, not_registered NO puede leer colecciones protegidas.
const visitante = "usr_not_registered";
let authActiva = false;
const bdVisitante = conectarComo(visitante,
  pwd("MONGO_USR_NOT_REGISTERED_PASSWORD", "CAMBIAR_CLAVE_NOT_REGISTERED"));
if (bdVisitante) {
  try {
    bdVisitante.col_users_adress.findOne();
  } catch (e) {
    authActiva = /not authorized|unauthorized|privilege|permission/i.test(e.message || String(e));
  }
}
authRoot();
print("  Modo detectado: " + (authActiva ? "AUTENTICACION ACTIVA" : "INITDB (sin autenticacion)"));
if (!authActiva) {
  print("  [NOTA] Las denegaciones reales se validan al repetir este script contra el VPS ya arrancado.");
}

// --------------------------------------------------------------------------
// 1) CREATE - resena de prueba con IDs reales de SQL (id_product=6, id_user=2)
// --------------------------------------------------------------------------
const idProductoPrueba = NumberInt(6);
const idUsuarioPrueba = NumberInt(2);
authComo("usr_admin", "MONGO_USR_ADMIN_PASSWORD", "CAMBIAR_CLAVE_ADMIN", "admin");
let docCreado = null;
try {
  db.col_products_reviews.deleteOne({ id_product: idProductoPrueba, id_user: idUsuarioPrueba, titulo: "PRUEBA_CRUD_TEMP" });
  db.col_products_reviews.insertOne({
    id_product: idProductoPrueba,
    id_user: idUsuarioPrueba,
    id_people: NumberInt(5),
    titulo: "PRUEBA_CRUD_TEMP",
    rating: NumberInt(4),
    comentario: "Resena temporal creada por la prueba automatizada de la Unidad 2.",
    estado_moderacion: "pendiente",
    fecha: new Date(),
    activo: true,
    origen_sql: "finalfinal.sql::tb_products.id_product=6,tb_users.id_user=2"
  });
  docCreado = db.col_products_reviews.findOne({ titulo: "PRUEBA_CRUD_TEMP" });
  registrar("CREATE", "usr_admin", "admin", "col_products_reviews", docCreado._id,
    "CREATE autorizado: resena temporal id_product=6 id_user=2", "exitoso", null, docCreado);
} catch (e) {
  print("  [ERROR CREATE] " + e.message);
}
verificar("CREATE inserta y respeta $jsonSchema", !!docCreado, "No se pudo insertar la resena de prueba");

// --------------------------------------------------------------------------
// 2) READ - filtros + proyeccion + explain textual
// --------------------------------------------------------------------------
authComo("usr_support", "MONGO_USR_SUPPORT_PASSWORD", "CAMBIAR_CLAVE_SUPPORT", "support");
try {
  const filtro = { id_product: NumberInt(6), rating: { $gte: NumberInt(4) } };
  const proyeccion = { id_product: 1, rating: 1, comentario: 1, _id: 0 };
  const filas = db.col_products_reviews.find(filtro, proyeccion).limit(3).toArray();
  authRoot();
  registrar("READ", "usr_support", "support", "col_products_reviews", "filtro_id_product_6",
    "READ autorizado: filtro {id_product:6,rating:{$gte:4}} + proyeccion, filas=" + filas.length,
    "exitoso", null, { filtro: filtro, proyeccion: proyeccion, filas: filas });
  verificar("READ con filtro y proyeccion", filas.length >= 1, "Sin resultados");
} catch (e) {
  authRoot();
  print("  [ERROR READ] " + e.message);
  verificar("READ con filtro y proyeccion", false, e.message);
}

// --------------------------------------------------------------------------
// 3) UPDATE - antes y despues
// --------------------------------------------------------------------------
authComo("usr_admin", "MONGO_USR_ADMIN_PASSWORD", "CAMBIAR_CLAVE_ADMIN", "admin");
try {
  const antes = db.col_products_reviews.findOne({ titulo: "PRUEBA_CRUD_TEMP" });
  db.col_products_reviews.updateOne({ _id: antes._id }, {
    $set: { rating: NumberInt(5), estado_moderacion: "aprobado" }
  });
  const despues = db.col_products_reviews.findOne({ _id: antes._id });
  registrar("UPDATE", "usr_admin", "admin", "col_products_reviews", String(antes._id),
    "UPDATE autorizado: rating 4->5 y estado_moderacion pendiente->aprobado",
    "exitoso", antes, despues);
  verificar("UPDATE cambia rating y estado", despues.rating === 5 && despues.estado_moderacion === "aprobado",
    "Valores posteriores incorrectos");
} catch (e) {
  print("  [ERROR UPDATE] " + e.message);
  verificar("UPDATE cambia rating y estado", false, e.message);
}

// --------------------------------------------------------------------------
// 4) DELETE - solo roles con privilegio de borrado (admin/superadmin)
// --------------------------------------------------------------------------
try {
  const antes = db.col_products_reviews.findOne({ titulo: "PRUEBA_CRUD_TEMP" });
  const res = db.col_products_reviews.deleteOne({ _id: antes._id });
  registrar("DELETE", "usr_admin", "admin", "col_products_reviews", String(antes._id),
    "DELETE autorizado: se elimina la resena temporal de la prueba", "exitoso", antes, null);
  verificar("DELETE elimina el documento temporal", res.deletedCount === 1, "deletedCount=0");
} catch (e) {
  print("  [ERROR DELETE] " + e.message);
  verificar("DELETE elimina el documento temporal", false, e.message);
}
authRoot();

// --------------------------------------------------------------------------
// 5) Operacion autorizada con rol limitado: buyer crea direccion real
// --------------------------------------------------------------------------
authComo("usr_buyer", "MONGO_USR_BUYER_PASSWORD", "CAMBIAR_CLAVE_BUYER", "buyer");
try {
  const doc = {
    id_user: NumberInt(2), id_people: NumberInt(5), nombre_completo: "JEIG (prueba buyer)",
    calle: "Calle Prueba Buyer", numero_exterior: "1", colonia: " Centro ",
    ciudad: "Pachuca", estado: "Hidalgo", codigo_postal: "42000", pais: "MX",
    tipo_direccion: "entrega", activa: true, fecha_creacion: new Date(), fecha_actualizacion: new Date()
  };
  // colonia con espacios no cumple minLength? si cumple; se normaliza antes de insertar.
  doc.colonia = "Centro";
  const bdBuyer = authActiva
    ? conectarComo("usr_buyer", pwd("MONGO_USR_BUYER_PASSWORD", "CAMBIAR_CLAVE_BUYER"))
    : db;
  const insertado = bdBuyer.col_users_adress.insertOne(doc);
  const idCreado = insertado.insertedId; // mongosh no siempre muta doc._id
  const visitas = bdBuyer.vw_public_reviews.find().limit(2).toArray();
  authRoot();
  registrar("CREATE", "usr_buyer", "buyer", "col_users_adress", idCreado,
    "CREATE autorizado con rol buyer + lectura de vw_public_reviews (" + visitas.length + " filas)",
    "exitoso", null, doc);
  verificar("buyer puede crear direccion y leer vista publica", true);
  db.col_users_adress.deleteOne({ _id: idCreado });
  registrar("DELETE", "usr_admin", "admin", "col_users_adress", idCreado,
    "Limpieza del documento temporal creado por buyer", "exitoso", doc, null);
} catch (e) {
  authRoot();
  print("  [ERROR BUYER] " + e.message);
  verificar("buyer puede crear direccion y leer vista publica", false, e.message);
}

// --------------------------------------------------------------------------
// 6) Intentos DENEGADOS por falta de privilegios
// --------------------------------------------------------------------------
print("== Pruebas de denegacion ==");
intentarDenegado("not_registered_no_puede_leer_col_users_adress", visitante, "not_registered", function (bd) {
  bd.col_users_adress.find().limit(1).toArray();
});
intentarDenegado("common_no_puede_insertar_resenas", "usr_common", "common", function (bd) {
  bd.col_products_reviews.insertOne({
    id_product: NumberInt(999999), id_user: NumberInt(2), id_people: NumberInt(5),
    rating: NumberInt(5), comentario: "Intento que debe ser denegado por el rol common",
    estado_moderacion: "aprobado", fecha: new Date(), activo: true
  });
});
// Los filtros usan IDs inexistentes para que, en modo initdb (sin auth), la
// prueba NO borre documentos reales de las colecciones sembradas.
intentarDenegado("buyer_no_puede_borrar_envios", "usr_buyer", "buyer", function (bd) {
  bd.col_shipment_tracking.deleteOne({ id_order: NumberInt(999999) });
});
intentarDenegado("seller_no_puede_borrar_logs", "usr_seller", "seller", function (bd) {
  bd.col_logs.deleteMany({ operacion: "__PRUEBA_DENEGACION__" });
});
authRoot();

// --------------------------------------------------------------------------
// Resumen
// --------------------------------------------------------------------------
print("=============================================================");
print(" RESUMEN: PASS=" + PASS + "  FAIL=" + FAIL +
      "  col_logs=" + db.col_logs.countDocuments({}) + " registros reales");
print(" NOTA: los FAIL en modo initdb son esperados porque no hay auth activa.");
print("=============================================================");
print("== Fin 06_tests_crud.js ==");
