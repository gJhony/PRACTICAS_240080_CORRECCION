// =============================================================================
// UTXJ - Unidad 2 - Apartado E (Indicadores 38-39)
// 03_seed_data.js - 12 documentos por coleccion funcional con IDs REALES SQL
// =============================================================================
// FUENTE DE LOS IDS: C:\Users\mario\OneDrive\Escritorio\finalfinal.sql
//   (dump MySQL de db_test_7b, practicas BDN 240080)
//   tb_users.id_user       -> 2,5,6,7,8,9,11,12,13,14,16,17
//   tb_people.id_people    -> 5,6,7,8,9,10,11,12,13,14,15,16
//   tb_products.id_product -> 1..12
//   tb_buyer_orders / tb_shipments NO traen filas en el dump; el campo id_order
//   usa la correlacion real con tb_people.id_people (documentado en README).
// PROHIBIDO sembrar col_logs: se llena solo con operaciones reales (06 y GraphQL).
// Idempotente: usa upserts por clave natural; se puede volver a ejecutar.
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");
const I = NumberInt;

// (id_user, id_people, id_product, nombre_persona, producto)
const REALES = [
  [2, 5, 1, "JEIG", "Boing Mango"],
  [5, 6, 2, "SARA", "Coca-Cola Original"],
  [6, 7, 3, "MAGO", "HyperX Microfono Plus"],
  [7, 8, 4, "PONCHO", "LogiTech Headset Gamer Lite"],
  [8, 9, 5, "JENY", "Apex Lampara LED Premium"],
  [9, 10, 6, "Dara", "Vertex Impresora Ultra"],
  [11, 11, 7, "Rene", "Pasta termica Cenit 8 gramos"],
  [12, 12, 8, "Aaron", "Procesador 8 nucleos Solara 4.2 GHz"],
  [13, 13, 9, "Sam", "Cable de red Cat7 Kukulcan 3 m"],
  [14, 14, 10, "Diego", "Mini proyector Kukulcan"],
  [16, 15, 11, "User16", "Monitor Andes 24 pulgadas"],
  [17, 16, 12, "User17", "Nova Headset Gamer Premium"]
];

const CIUDADES = [
  ["Pachuca", "Hidalgo", "42000"], ["Xicotepec", "Puebla", "73180"],
  ["Mexico City", "Ciudad de Mexico", "06000"], ["Guadalajara", "Jalisco", "44100"],
  ["Monterrey", "Nuevo Leon", "64000"], ["Puebla", "Puebla", "72000"],
  ["Queretaro", "Queretaro", "76000"], ["Merida", "Yucatan", "97000"],
  ["Tijuana", "Baja California", "22000"], ["Leon", "Guanajuato", "37000"],
  ["Oaxaca", "Oaxaca", "68000"], ["Hermosillo", "Sonora", "83000"]
];

const TIPOS = ["domicilio", "entrega", "facturacion", "oficina", "domicilio", "entrega",
               "facturacion", "oficina", "domicilio", "entrega", "facturacion", "oficina"];
const RATINGS = [5, 4, 3, 5, 2, 4, 5, 3, 4, 1, 5, 4];
const MODERACION = ["aprobado", "aprobado", "aprobado", "pendiente", "aprobado", "aprobado",
                    "aprobado", "rechazado", "aprobado", "aprobado", "pendiente", "aprobado"];
const PAQUETERIAS = ["Estafeta", "DHL Express", "FedEx", "Correos de Mexico", "UPS", "J&T Express",
                     "Estafeta", "DHL Express", "FedEx", "UPS", "Correos de Mexico", "J&T Express"];
const ESTADOS_ENVIO = ["entregado", "en_transito", "entregado", "pendiente", "en_transito", "entregado",
                       "entregado", "devuelto", "en_transito", "entregado", "pendiente", "entregado"];

const HOY = ISODate("2026-11-20T09:00:00Z");
function diasAtras(n) { return new Date(HOY.getTime() - n * 24 * 60 * 60 * 1000); }

function upsert(coleccion, filtro, documento, etiqueta) {
  const resultado = db.getCollection(coleccion).updateOne(
    filtro,
    { $setOnInsert: documento },
    { upsert: true }
  );
  if (resultado.upsertedCount === 1) print("  [INSERT] " + etiqueta);
  else print("  [EXISTE] " + etiqueta);
}

print("== Apartado E: sembrando 12 direcciones reales ==");
REALES.forEach(function (fila, idx) {
  const idUser = fila[0], idPeople = fila[1], nombre = fila[3];
  const ciudad = CIUDADES[idx];
  upsert("col_users_adress",
    { id_user: I(idUser), id_people: I(idPeople), tipo_direccion: TIPOS[idx], calle: "Calle Real " + (idx + 1) },
    {
      id_user: I(idUser),
      id_people: I(idPeople),
      nombre_completo: nombre + " (tb_people #" + idPeople + ")",
      calle: "Calle Real " + (idx + 1),
      numero_exterior: String(100 + idx),
      numero_interior: idx % 3 === 0 ? null : "B",
      colonia: "Colonia Universitaria",
      ciudad: ciudad[0],
      estado: ciudad[1],
      codigo_postal: ciudad[2],
      pais: "MX",
      tipo_direccion: TIPOS[idx],
      activa: idx % 5 !== 4,
      fecha_creacion: diasAtras(40 - idx),
      fecha_actualizacion: diasAtras(idx),
      origen_sql: "finalfinal.sql::tb_users.id_user=" + idUser + ",tb_people.id_people=" + idPeople
    },
    "direccion id_user=" + idUser + " id_people=" + idPeople);
});

print("== Apartado E: sembrando 12 resenas reales ==");
REALES.forEach(function (fila, idx) {
  const idUser = fila[0], idPeople = fila[1], idProduct = fila[2], producto = fila[4];
  upsert("col_products_reviews",
    { id_product: I(idProduct), id_user: I(idUser) },
    {
      id_product: I(idProduct),
      id_user: I(idUser),
      id_people: I(idPeople),
      titulo: "Resena verificada " + producto.substring(0, 32),
      rating: I(RATINGS[idx]),
      comentario: "Producto " + producto + " adquirido en la practica U2; entrega y calidad consistentes con el catalogo SQL.",
      estado_moderacion: MODERACION[idx],
      fecha: diasAtras(30 - idx),
      activo: MODERACION[idx] !== "rechazado",
      origen_sql: "finalfinal.sql::tb_products.id_product=" + idProduct + ",tb_users.id_user=" + idUser
    },
    "resena id_product=" + idProduct + " id_user=" + idUser + " rating=" + RATINGS[idx]);
});

print("== Apartado E: sembrando 12 envios reales ==");
REALES.forEach(function (fila, idx) {
  const idUser = fila[0], idPeople = fila[1];
  const idOrder = idPeople; // correlacion con entidad real tb_people (ver README)
  const estado = ESTADOS_ENVIO[idx];
  const tracking = "TRK-UTXJ-40085-" + String(idx + 1).padStart(3, "0");
  const ciudad = CIUDADES[idx];
  upsert("col_shipment_tracking",
    { id_order: I(idOrder), tracking_number: tracking },
    {
      id_order: I(idOrder),
      id_user: I(idUser),
      id_people: I(idPeople),
      tracking_number: tracking,
      paqueteria: PAQUETERIAS[idx],
      estado: estado,
      fecha_envio: diasAtras(25 - idx),
      fecha_entrega: estado === "entregado" ? diasAtras(20 - idx) : null,
      historial: [
        { fecha: diasAtras(25 - idx), estado: "pendiente", descripcion: "Guia generada desde pedido SQL", ubicacion: "Pachuca, Hidalgo" },
        { fecha: diasAtras(24 - idx), estado: "en_transito", descripcion: "Paquete en centro de distribucion", ubicacion: ciudad[0] + ", " + ciudad[1] },
        { fecha: diasAtras(20 - idx), estado: estado, descripcion: "Ultimo evento registrado del envio", ubicacion: ciudad[0] }
      ],
      direccion_entrega: {
        ciudad: ciudad[0], estado: ciudad[1], codigo_postal: ciudad[2], pais: "MX"
      },
      observaciones: "Consistencia SQL-NoSQL verificada con finalfinal.sql (id_people=" + idPeople + ")",
      origen_sql: "finalfinal.sql::tb_people.id_people=" + idPeople + " -> id_order (correlacion)"
    },
    "envio id_order=" + idOrder + " guia=" + tracking);
});

print("== Totales ==");
print("  col_users_adress     : " + db.col_users_adress.countDocuments({}));
print("  col_products_reviews : " + db.col_products_reviews.countDocuments({}));
print("  col_shipment_tracking: " + db.col_shipment_tracking.countDocuments({}));
print("  col_logs (debe crecer solo con operaciones reales): " + db.col_logs.countDocuments({}));
print("== Fin 03_seed_data.js ==");
