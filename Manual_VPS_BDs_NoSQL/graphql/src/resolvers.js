const { getDb } = require("./db");
const { conAuditoria } = require("./audit");
const { C } = require("./roles");
const { JSONObject } = require("./scalars");

function normalizar(valor) {
  if (valor === null || valor === undefined) return valor;
  if (valor instanceof Date) return valor.toISOString();
  if (typeof valor === "object" && typeof valor.toHexString === "function") return valor.toHexString();
  if (Array.isArray(valor)) return valor.map(normalizar);
  if (typeof valor === "object") {
    const salida = {};
    Object.keys(valor).forEach((k) => { salida[k] = normalizar(valor[k]); });
    return salida;
  }
  return valor;
}

function pagina(limit, offset) {
  return {
    limit: Math.min(Math.max(Number(limit) || 20, 1), 100),
    skip: Math.max(Number(offset) || 0, 0)
  };
}

function col(nombre) { return getDb().collection(nombre); }

const resolvers = {
  JSONObject,

  Query: {
    health: () => "ok",

    addresses: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.ADDRESS, recurso: C.ADDRESS,
      documento_id: args.idUser ? `id_user_${args.idUser}` : "todos",
      descripcion: "Consulta de direcciones con filtros dinamicos y paginacion"
    }, async () => {
      const filtro = {};
      if (args.idUser != null) filtro.id_user = args.idUser;
      if (args.idPeople != null) filtro.id_people = args.idPeople;
      if (args.activa != null) filtro.activa = args.activa;
      const { limit, skip } = pagina(args.limit, args.offset);
      const filas = await col(C.ADDRESS).find(filtro).sort({ fecha_creacion: -1 }).skip(skip).limit(limit).toArray();
      return filas.map(normalizar);
    }),

    reviews: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.REVIEWS, recurso: C.REVIEWS,
      documento_id: args.idProduct ? `id_product_${args.idProduct}` : "todos",
      descripcion: "Consulta de resenas con filtros id_product/id_user/estado"
    }, async () => {
      const filtro = {};
      if (args.idProduct != null) filtro.id_product = args.idProduct;
      if (args.idUser != null) filtro.id_user = args.idUser;
      if (args.estado) filtro.estado_moderacion = args.estado;
      const { limit, skip } = pagina(args.limit, args.offset);
      const filas = await col(C.REVIEWS).find(filtro).sort({ fecha: -1 }).skip(skip).limit(limit).toArray();
      return filas.map(normalizar);
    }),

    shipments: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.SHIPMENTS, recurso: C.SHIPMENTS,
      documento_id: args.trackingNumber || (args.idOrder ? `id_order_${args.idOrder}` : "todos"),
      descripcion: "Consulta de envios con filtros dinamicos y paginacion"
    }, async () => {
      const filtro = {};
      if (args.idOrder != null) filtro.id_order = args.idOrder;
      if (args.estado) filtro.estado = args.estado;
      if (args.trackingNumber) filtro.tracking_number = args.trackingNumber;
      const { limit, skip } = pagina(args.limit, args.offset);
      const filas = await col(C.SHIPMENTS).find(filtro).sort({ fecha_envio: -1 }).skip(skip).limit(limit).toArray();
      return filas.map(normalizar);
    }),

    logs: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.LOGS, recurso: C.LOGS,
      documento_id: args.usuario || "auditoria",
      descripcion: "Consulta de auditoria con filtros operacion/usuario"
    }, async () => {
      const filtro = {};
      if (args.operacion) filtro.operacion = args.operacion;
      if (args.usuario) filtro.usuario = args.usuario;
      const { limit, skip } = pagina(args.limit, args.offset);
      const filas = await col(C.LOGS).find(filtro).sort({ fecha_hora: -1 }).skip(skip).limit(limit).toArray();
      return filas.map(normalizar);
    }),

    // Agregacion optimizada: $match -> $group -> $match -> $sort -> $project -> $skip/$limit
    productsRatingSummary: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_RATING, recurso: C.V_RATING,
      documento_id: "agregacion_productos",
      descripcion: `Agregacion dinamica minReviews=${args.minReviews}, orden=${args.orden}`
    }, async () => {
      const permitidos = ["total_resenas", "promedio_rating", "rating_maximo"];
      const campo = permitidos.indexOf(args.orden) !== -1 ? args.orden : "total_resenas";
      const sort = {}; sort[campo] = -1;
      const { limit, skip } = pagina(args.limit, args.offset);
      const pipeline = [
        { $match: { estado_moderacion: "aprobado", activo: true } },
        { $group: {
            _id: "$id_product",
            promedio_raw: { $avg: "$rating" },
            total_resenas: { $sum: 1 },
            rating_maximo: { $max: "$rating" },
            rating_minimo: { $min: "$rating" }
        } },
        { $match: { $expr: { $gte: ["$total_resenas", Number(args.minReviews) || 1] } } },
        { $project: {
            _id: 0, id_product: "$_id",
            promedio_rating: { $round: ["$promedio_raw", 2] },
            total_resenas: 1, rating_maximo: 1, rating_minimo: 1
        } },
        { $sort: sort },
        { $skip: skip },
        { $limit: limit }
      ];
      const filas = await col(C.REVIEWS).aggregate(pipeline, { allowDiskUse: true }).toArray();
      return filas.map(normalizar);
    }),

    // --- Vistas ---
    publicReviews: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_PUBLIC, recurso: C.V_PUBLIC, documento_id: "vw_public_reviews",
      descripcion: "Vista publica de resenas aprobadas"
    }, async () => {
      const { limit, skip } = pagina(args.limit, args.offset);
      return (await col(C.V_PUBLIC).find({}).sort({ fecha: -1 }).skip(skip).limit(limit).toArray()).map(normalizar);
    }),

    activeShipmentsView: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_SHIP, recurso: C.V_SHIP, documento_id: "vw_active_shipments",
      descripcion: "Vista de envios activos"
    }, async () => {
      const { limit, skip } = pagina(args.limit, args.offset);
      return (await col(C.V_SHIP).find({}).sort({ fecha_envio: -1 }).skip(skip).limit(limit).toArray()).map(normalizar);
    }),

    userAddressesActiveView: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_ADDR, recurso: C.V_ADDR, documento_id: "vw_user_addresses_active",
      descripcion: "Vista de direcciones activas sin PII de calle"
    }, async () => {
      const { limit, skip } = pagina(args.limit, args.offset);
      return (await col(C.V_ADDR).find({}).skip(skip).limit(limit).toArray()).map(normalizar);
    }),

    productsRatingSummaryView: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_RATING, recurso: C.V_RATING, documento_id: "vw_products_rating_summary",
      descripcion: "Vista de resumen de calificaciones"
    }, async () => {
      const { limit, skip } = pagina(args.limit, args.offset);
      return (await col(C.V_RATING).find({}).skip(skip).limit(limit).toArray()).map(normalizar);
    }),

    auditLogsRecentView: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "READ", coleccion: C.V_AUDIT, recurso: C.V_AUDIT, documento_id: "vw_audit_logs_recent",
      descripcion: "Vista de auditoria reciente"
    }, async () => {
      const { limit, skip } = pagina(args.limit, args.offset);
      return (await col(C.V_AUDIT).find({}).skip(skip).limit(limit).toArray()).map(normalizar);
    })
  },

  Mutation: {
    createAddress: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "CREATE", coleccion: C.ADDRESS, recurso: C.ADDRESS,
      documento_id: `id_user_${args.input.id_user}`,
      descripcion: "Creacion de direccion desde GraphQL"
    }, async () => {
      const i = args.input;
      const doc = {
        id_user: i.id_user, id_people: i.id_people,
        nombre_completo: i.nombre_completo, calle: i.calle,
        numero_exterior: i.numero_exterior, numero_interior: i.numero_interior || null,
        colonia: i.colonia, ciudad: i.ciudad, estado: i.estado,
        codigo_postal: i.codigo_postal, pais: i.pais, tipo_direccion: i.tipo_direccion,
        activa: true, fecha_creacion: new Date(), fecha_actualizacion: new Date(),
        origen_sql: "graphql"
      };
      const res = await col(C.ADDRESS).insertOne(doc);
      return normalizar({ ...doc, _id: res.insertedId });
    }),

    createReview: async (_root, args, ctx) => conAuditoria(ctx, {
      operacion: "CREATE", coleccion: C.REVIEWS, recurso: C.REVIEWS,
      documento_id: `id_product_${args.input.id_product}`,
      descripcion: "Creacion de resena desde GraphQL"
    }, async () => {
      const i = args.input;
      if (i.rating < 1 || i.rating > 5) throw new Error("rating debe ser un entero entre 1 y 5");
      const doc = {
        id_product: i.id_product, id_user: i.id_user, id_people: i.id_people,
        titulo: i.titulo || "Resena GraphQL", rating: i.rating, comentario: i.comentario,
        estado_moderacion: "pendiente", fecha: new Date(), activo: true, origen_sql: "graphql"
      };
      const res = await col(C.REVIEWS).insertOne(doc);
      return normalizar({ ...doc, _id: res.insertedId });
    }),

    updateShipmentStatus: async (_root, args, ctx) => {
      const antes = await col(C.SHIPMENTS).findOne({ id_order: args.input.id_order });
      return conAuditoria(ctx, {
        operacion: "UPDATE", coleccion: C.SHIPMENTS, recurso: C.SHIPMENTS,
        documento_id: `id_order_${args.input.id_order}`,
        descripcion: `Cambio de estado de envio a '${args.input.estado}'`,
        datos_anteriores: antes ? normalizar(antes) : null
      }, async () => {
        const estados = ["pendiente", "en_transito", "entregado", "devuelto", "cancelado"];
        if (estados.indexOf(args.input.estado) === -1) throw new Error("Estado de envio no valido");
        const ahora = new Date();
        const actualizacion = {
          $set: {
            estado: args.input.estado,
            fecha_entrega: args.input.estado === "entregado" ? ahora : null
          },
          $push: {
            historial: {
              fecha: ahora,
              estado: args.input.estado,
              descripcion: args.input.descripcion || `Estatus actualizado via GraphQL por ${ctx.user}`,
              ubicacion: "API GraphQL"
            }
          }
        };
        await col(C.SHIPMENTS).updateOne({ id_order: args.input.id_order }, actualizacion);
        const despues = await col(C.SHIPMENTS).findOne({ id_order: args.input.id_order });
        return normalizar(despues);
      });
    },

    moderateReview: async (_root, args, ctx) => {
      const filtro = { id_product: args.idProduct, id_user: args.idUser };
      const antes = await col(C.REVIEWS).findOne(filtro);
      return conAuditoria(ctx, {
        operacion: "UPDATE", coleccion: C.REVIEWS, recurso: C.REVIEWS,
        documento_id: `id_product_${args.idProduct}_id_user_${args.idUser}`,
        descripcion: `Moderacion de resena a '${args.estado}'`,
        datos_anteriores: antes ? normalizar(antes) : null
      }, async () => {
        const estados = ["pendiente", "aprobado", "rechazado"];
        if (estados.indexOf(args.estado) === -1) throw new Error("Estado de moderacion no valido");
        await col(C.REVIEWS).updateOne(filtro, {
          $set: { estado_moderacion: args.estado, activo: args.estado !== "rechazado" }
        });
        return normalizar(await col(C.REVIEWS).findOne(filtro));
      });
    },

    deleteReview: async (_root, args, ctx) => {
      const filtro = { id_product: args.idProduct, id_user: args.idUser };
      const antes = await col(C.REVIEWS).findOne(filtro);
      return conAuditoria(ctx, {
        operacion: "DELETE", coleccion: C.REVIEWS, recurso: C.REVIEWS,
        documento_id: `id_product_${args.idProduct}_id_user_${args.idUser}`,
        descripcion: "Eliminacion de resena desde GraphQL",
        datos_anteriores: antes ? normalizar(antes) : null
      }, async () => {
        const res = await col(C.REVIEWS).deleteOne(filtro);
        return { eliminados: res.deletedCount, descripcion: "Resena eliminada y auditada" };
      });
    }
  }
};

module.exports = { resolvers };
