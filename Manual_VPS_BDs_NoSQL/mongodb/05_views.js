// =============================================================================
// UTXJ - Unidad 2 - Apartado E (Indicadores 41-42)
// 05_views.js - 5 vistas MongoDB con proposito documentado
// =============================================================================
// Las vistas se ejecutan con los privilegios del usuario que las consulta:
// por eso not_registered solo puede leer vw_public_reviews.
// Re-executable: se recrean (son derivadas, no almacenan datos propios).
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");

function crearVista(nombre, fuente, pipeline, proposito) {
  const existe = db.getCollectionNames().indexOf(nombre) !== -1;
  if (existe) {
    db.getCollection(nombre).drop();
    print("  [RECREADA] " + nombre);
  }
  db.createView(nombre, fuente, pipeline);
  print("  [OK] " + nombre + " -> " + proposito);
}

print("== Apartado E: definiendo 5 vistas ==");

// 1) vw_public_reviews: UNICA vista autorizada para not_registered.
//    Expone solo resenas aprobadas y activas, sin PII del usuario.
crearVista("vw_public_reviews", "col_products_reviews", [
  { $match: { estado_moderacion: "aprobado", activo: true } },
  { $sort: { fecha: -1 } },
  { $project: {
      _id: 1,
      id_product: 1,
      rating: 1,
      titulo: 1,
      comentario: 1,
      fecha: 1
  } }
], "catalogo publico de resenas aprobadas (visitantes y compradores)");

// 2) vw_active_shipments: panel logistico de guias pendientes/en transito.
crearVista("vw_active_shipments", "col_shipment_tracking", [
  { $match: { estado: { $in: ["pendiente", "en_transito"] } } },
  { $sort: { fecha_envio: -1 } },
  { $project: {
      _id: 1,
      id_order: 1,
      id_user: 1,
      tracking_number: 1,
      paqueteria: 1,
      estado: 1,
      fecha_envio: 1,
      ciudad_destino: "$direccion_entrega.ciudad",
      ultimo_evento: { $arrayElemAt: ["$historial", -1] }
  } }
], "envios en curso para soporte y seguimiento del comprador");

// 3) vw_user_addresses_active: direcciones activas SIN numero de calle (PII).
crearVista("vw_user_addresses_active", "col_users_adress", [
  { $match: { activa: true } },
  { $project: {
      _id: 1,
      id_user: 1,
      id_people: 1,
      nombre_completo: 1,
      tipo_direccion: 1,
      ciudad: 1,
      estado: 1,
      codigo_postal: 1,
      pais: 1,
      fecha_actualizacion: 1
  } }
], "datos de entrega para vendedor/soporte sin exponer calle ni numero");

// 4) vw_products_rating_summary: agregacion de calificaciones por producto.
crearVista("vw_products_rating_summary", "col_products_reviews", [
  { $match: { estado_moderacion: "aprobado", activo: true } },
  { $group: {
      _id: "$id_product",
      promedio_raw: { $avg: "$rating" },
      total_resenas: { $sum: 1 },
      rating_maximo: { $max: "$rating" },
      rating_minimo: { $min: "$rating" }
  } },
  { $project: {
      _id: 0,
      id_product: "$_id",
      promedio_rating: { $round: ["$promedio_raw", 2] },
      total_resenas: 1,
      rating_maximo: 1,
      rating_minimo: 1
  } },
  { $sort: { total_resenas: -1, promedio_rating: -1 } }
], "resumen de reputacion por producto (estrellas y volumen de resenas)");

// 5) vw_audit_logs_recent: auditoria reciente para roles autorizados.
crearVista("vw_audit_logs_recent", "col_logs", [
  { $sort: { fecha_hora: -1 } },
  { $limit: 200 },
  { $project: {
      _id: 1,
      fecha_hora: 1,
      operacion: 1,
      usuario: 1,
      rol: 1,
      ip: 1,
      coleccion: 1,
      documento_id: 1,
      descripcion: 1,
      estado: 1
  } }
], "trazabilidad reciente de operaciones (solo admin y support)");

print("== Vistas disponibles ==");
db.getCollectionNames().filter(function (n) { return n.indexOf("vw_") === 0; }).forEach(function (v) {
  print("  - " + v + " (" + db.getCollection(v).countDocuments({}) + " documentos)");
});
print("== Fin 05_views.js ==");
