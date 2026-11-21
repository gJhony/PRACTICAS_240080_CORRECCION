// =============================================================================
// UTXJ - Unidad 2 - Apartado E (Indicador 40)
// 04_indexes.js - Indices simples y compuestos justificados (sin redundantes)
// =============================================================================
// Cada indice indica la consulta que optimiza. Se crea solo si no existe.
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");

function crearIndice(coleccion, claves, nombre, opciones, justificacion) {
  const nombreFinal = nombre || Object.keys(claves).map(function (k) {
    return k + "_" + claves[k];
  }).join("_");
  const existe = db.getCollection(coleccion).getIndexes().some(function (ix) {
    return ix.name === nombreFinal;
  });
  if (existe) {
    print("  [EXISTE] " + coleccion + "." + nombreFinal);
    return;
  }
  const opts = opciones || {};
  opts.name = nombreFinal;
  db.getCollection(coleccion).createIndex(claves, opts);
  print("  [CREADO] " + coleccion + "." + nombreFinal + " -> " + justificacion);
}

print("== Apartado E: creando indices justificados ==");

// --- col_users_adress ---------------------------------------------------------
// Consulta: direcciones activas de un usuario (GraphQL addresses + vista activa).
crearIndice("col_users_adress", { id_user: 1, activa: 1 }, "idx_addr_id_user_activa", {},
  "find({id_user, activa:true}) - grafico de direcciones activas por comprador");

// Consulta: localizar direcciones por id_people real de SQL (auditoria U2).
crearIndice("col_users_adress", { id_people: 1 }, "idx_addr_id_people", {},
  "find({id_people}) - correlacion con tb_people.id_people");

// Consulta: filtro geografico por codigo postal (entregas por zona).
crearIndice("col_users_adress", { codigo_postal: 1, ciudad: 1 }, "idx_addr_cp_ciudad", {},
  "find({codigo_postal, ciudad}) - consultas de cobertura de entrega");

// --- col_products_reviews -----------------------------------------------------
// Unico: evita resenas duplicadas del mismo usuario sobre el mismo producto.
// Ademas optimiza find({id_product}) por ser prefijo izquierdo: NO crear otro.
crearIndice("col_products_reviews", { id_product: 1, id_user: 1 }, "idx_rev_product_user_uq", { unique: true },
  "find({id_product}) y restriccion de unicidad producto+usuario (evita indice redundante)");

// Consulta: resenas emitidas por un usuario ordenadas por fecha.
crearIndice("col_products_reviews", { id_user: 1, fecha: -1 }, "idx_rev_user_fecha", {},
  "find({id_user}).sort({fecha:-1}) - historial de resenas del comprador");

// Consulta: bandeja de moderacion (pendientes primero por fecha).
crearIndice("col_products_reviews", { estado_moderacion: 1, fecha: -1 }, "idx_rev_moderacion_fecha", {},
  "find({estado_moderacion:'pendiente'}).sort({fecha:-1}) - moderation queue");

// --- col_shipment_tracking ----------------------------------------------------
// Unico: numero de guia (igual que UNIQUE KEY en tb_shipments.tracking_number).
crearIndice("col_shipment_tracking", { tracking_number: 1 }, "idx_ship_tracking_uq", { unique: true },
  "find({tracking_number}) y unicidad de guia (mismo constraint que el SQL)");

// Consulta: todos los envios de un pedido SQL.
crearIndice("col_shipment_tracking", { id_order: 1 }, "idx_ship_id_order", {},
  "find({id_order}) - envios asociados a un pedido");

// Consulta: vw_active_shipments y panel de logistica por estado.
crearIndice("col_shipment_tracking", { estado: 1, fecha_envio: -1 }, "idx_ship_estado_fecha", {},
  "find({estado:{$in:[...]}}).sort({fecha_envio:-1}) - vista de envios activos");

// Consulta: envios de un usuario filtrados por estado.
crearIndice("col_shipment_tracking", { id_user: 1, estado: 1 }, "idx_ship_user_estado", {},
  "find({id_user, estado}) - seguimiento del comprador");

// --- col_logs -----------------------------------------------------------------
// Consulta: auditoria cronologica y vw_audit_logs_recent.
crearIndice("col_logs", { fecha_hora: -1 }, "idx_logs_fecha", {},
  "find().sort({fecha_hora:-1}) - vista de auditoria reciente");

// Consulta: filtrar auditoria por tipo de operacion (CREATE/UPDATE/AUTH_DENIED).
crearIndice("col_logs", { operacion: 1, fecha_hora: -1 }, "idx_logs_operacion_fecha", {},
  "find({operacion}).sort({fecha_hora:-1}) - revision de intentos denegados");

// Consulta: rastrear todos los eventos de un usuario/rol.
crearIndice("col_logs", { usuario: 1, fecha_hora: -1 }, "idx_logs_usuario_fecha", {},
  "find({usuario}).sort({fecha_hora:-1}) - trazabilidad por integrante del equipo");

// Consulta: trazabilidad de un documento especifico.
crearIndice("col_logs", { coleccion: 1, documento_id: 1 }, "idx_logs_coleccion_doc", {},
  "find({coleccion, documento_id}) - historia de cambios de un documento");

print("== Indices por coleccion ==");
["col_users_adress", "col_products_reviews", "col_shipment_tracking", "col_logs"].forEach(function (c) {
  print("  " + c + ": " + db.getCollection(c).getIndexes().length);
});
print("== Fin 04_indexes.js ==");
