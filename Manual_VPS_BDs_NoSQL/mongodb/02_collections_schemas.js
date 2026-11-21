// =============================================================================
// UTXJ - Unidad 2 - Apartado E (Indicadores 30-37)
// 02_collections_schemas.js - 4 colecciones con $jsonSchema estricto
// =============================================================================
// Ejecutable en initdb o manualmente con mongosh sobre ecommerce_nosql.
// Re-executable: si la coleccion existe se actualiza el validador con collMod.
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");

function ensureCollection(name, validator, descripcion) {
  const exists = db.getCollectionNames().indexOf(name) !== -1;
  if (exists) {
    db.runCommand({
      collMod: name,
      validator: validator,
      validationLevel: "strict",
      validationAction: "error"
    });
    print("  [OK] Validador actualizado: " + name + " (" + descripcion + ")");
  } else {
    db.createCollection(name, {
      validator: validator,
      validationLevel: "strict",
      validationAction: "error"
    });
    print("  [OK] Coleccion creada: " + name + " (" + descripcion + ")");
  }
}

print("== Apartado E: esquemas strict en ecommerce_nosql ==");

// -----------------------------------------------------------------------------
// 1) col_users_adress - direcciones de personas/usuarios del e-commerce SQL.
//    id_user e id_people son los IDs REALES de tb_users / tb_people.
// -----------------------------------------------------------------------------
ensureCollection("col_users_adress", {
  $jsonSchema: {
    bsonType: "object",
    title: "Direccion de usuario validada",
    required: [
      "_id", "id_user", "id_people", "nombre_completo", "calle", "numero_exterior",
      "colonia", "ciudad", "estado", "codigo_postal", "pais", "tipo_direccion",
      "activa", "fecha_creacion", "fecha_actualizacion"
    ],
    additionalProperties: false,
    properties: {
      _id: { bsonType: "objectId" },
      id_user: { bsonType: "int", minimum: 1, description: "FK real a tb_users.id_user" },
      id_people: { bsonType: "int", minimum: 1, description: "FK real a tb_people.id_people" },
      nombre_completo: { bsonType: "string", minLength: 3, maxLength: 120 },
      calle: { bsonType: "string", minLength: 3, maxLength: 150 },
      numero_exterior: { bsonType: "string", minLength: 1, maxLength: 10 },
      numero_interior: { bsonType: ["string", "null"], maxLength: 10 },
      colonia: { bsonType: "string", minLength: 2, maxLength: 100 },
      ciudad: { bsonType: "string", minLength: 2, maxLength: 80 },
      estado: { bsonType: "string", minLength: 2, maxLength: 80 },
      codigo_postal: { bsonType: "string", pattern: "^[0-9]{5}$" },
      pais: { bsonType: "string", pattern: "^[A-Z]{2,3}$" },
      tipo_direccion: { enum: ["domicilio", "entrega", "facturacion", "oficina"] },
      activa: { bsonType: "bool" },
      fecha_creacion: { bsonType: "date" },
      fecha_actualizacion: { bsonType: "date" },
      origen_sql: { bsonType: "string", maxLength: 120 }
    }
  }
}, "direcciones con FK SQL");

// -----------------------------------------------------------------------------
// 2) col_products_reviews - resenas de productos con calificacion entera 1-5.
//    id_product e id_user son IDs REALES de tb_products / tb_users.
// -----------------------------------------------------------------------------
ensureCollection("col_products_reviews", {
  $jsonSchema: {
    bsonType: "object",
    title: "Resena de producto validada",
    required: [
      "_id", "id_product", "id_user", "id_people", "rating", "comentario",
      "estado_moderacion", "fecha", "activo"
    ],
    additionalProperties: false,
    properties: {
      _id: { bsonType: "objectId" },
      id_product: { bsonType: "int", minimum: 1, description: "FK real a tb_products.id_product" },
      id_user: { bsonType: "int", minimum: 1, description: "FK real a tb_users.id_user" },
      id_people: { bsonType: "int", minimum: 1, description: "FK real a tb_people.id_people" },
      titulo: { bsonType: "string", minLength: 3, maxLength: 100 },
      rating: { bsonType: "int", minimum: 1, maximum: 5, description: "Calificacion entera 1-5" },
      comentario: { bsonType: "string", minLength: 5, maxLength: 1000 },
      estado_moderacion: { enum: ["pendiente", "aprobado", "rechazado"] },
      fecha: { bsonType: "date" },
      activo: { bsonType: "bool" },
      origen_sql: { bsonType: "string", maxLength: 120 }
    }
  }
}, "resenas 1-5 con moderacion");

// -----------------------------------------------------------------------------
// 3) col_shipment_tracking - envios con historial de eventos.
//    id_order corresponde al dominio de tb_buyer_orders.id_buyer_order (ver
//    nota de trazabilidad en README: el dump no trae filas de pedidos).
// -----------------------------------------------------------------------------
ensureCollection("col_shipment_tracking", {
  $jsonSchema: {
    bsonType: "object",
    title: "Seguimiento de envio validado",
    required: [
      "_id", "id_order", "id_user", "id_people", "tracking_number", "paqueteria",
      "estado", "fecha_envio", "historial", "direccion_entrega"
    ],
    additionalProperties: false,
    properties: {
      _id: { bsonType: "objectId" },
      id_order: { bsonType: "int", minimum: 1, description: "Correlacion con pedido SQL" },
      id_user: { bsonType: "int", minimum: 1 },
      id_people: { bsonType: "int", minimum: 1 },
      tracking_number: { bsonType: "string", minLength: 6, maxLength: 60 },
      paqueteria: { bsonType: "string", minLength: 2, maxLength: 80 },
      estado: { enum: ["pendiente", "en_transito", "entregado", "devuelto", "cancelado"] },
      fecha_envio: { bsonType: "date" },
      fecha_entrega: { bsonType: ["date", "null"] },
      historial: {
        bsonType: "array",
        minItems: 1,
        items: {
          bsonType: "object",
          required: ["fecha", "estado", "descripcion"],
          additionalProperties: false,
          properties: {
            fecha: { bsonType: "date" },
            estado: { bsonType: "string", minLength: 3, maxLength: 30 },
            descripcion: { bsonType: "string", minLength: 3, maxLength: 200 },
            ubicacion: { bsonType: "string", maxLength: 100 }
          }
        }
      },
      direccion_entrega: {
        bsonType: "object",
        required: ["ciudad", "estado", "codigo_postal", "pais"],
        additionalProperties: false,
        properties: {
          ciudad: { bsonType: "string", minLength: 2, maxLength: 80 },
          estado: { bsonType: "string", minLength: 2, maxLength: 80 },
          codigo_postal: { bsonType: "string", pattern: "^[0-9]{5}$" },
          pais: { bsonType: "string", pattern: "^[A-Z]{2,3}$" }
        }
      },
      observaciones: { bsonType: "string", maxLength: 300 },
      origen_sql: { bsonType: "string", maxLength: 120 }
    }
  }
}, "envios con historial embebido");

// -----------------------------------------------------------------------------
// 4) col_logs - auditoria y trazabilidad REAL (nunca se siembra a mano).
// -----------------------------------------------------------------------------
ensureCollection("col_logs", {
  $jsonSchema: {
    bsonType: "object",
    title: "Registro de auditoria",
    required: [
      "_id", "fecha_hora", "operacion", "usuario", "rol", "ip", "coleccion",
      "documento_id", "descripcion", "estado"
    ],
    additionalProperties: false,
    properties: {
      _id: { bsonType: "objectId" },
      fecha_hora: { bsonType: "date" },
      operacion: { enum: ["CREATE", "READ", "UPDATE", "DELETE", "AUTH_DENIED"] },
      usuario: { bsonType: "string", minLength: 1, maxLength: 80 },
      rol: { bsonType: "string", minLength: 1, maxLength: 40 },
      ip: { bsonType: "string", minLength: 3, maxLength: 60 },
      coleccion: { bsonType: "string", minLength: 1, maxLength: 80 },
      documento_id: { bsonType: "string", minLength: 1, maxLength: 120 },
      descripcion: { bsonType: "string", minLength: 3, maxLength: 500 },
      estado: { enum: ["exitoso", "denegado", "error"] },
      datos_anteriores: { bsonType: ["object", "null"] },
      datos_posteriores: { bsonType: ["object", "null"] },
      correlation_id: { bsonType: "string", maxLength: 80 }
    }
  }
}, "auditoria de operaciones reales");

print("== Colecciones finales: " + db.getCollectionNames().join(", ") + " ==");
print("== Fin 02_collections_schemas.js ==");
