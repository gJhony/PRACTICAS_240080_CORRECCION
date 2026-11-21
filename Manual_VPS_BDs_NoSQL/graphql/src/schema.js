const { gql } = require("apollo-server-express");

const typeDefs = gql`
  scalar JSONObject

  type Address {
    _id: String
    id_user: Int!
    id_people: Int!
    nombre_completo: String!
    calle: String
    numero_exterior: String
    colonia: String
    ciudad: String!
    estado: String!
    codigo_postal: String!
    pais: String!
    tipo_direccion: String!
    activa: Boolean!
    fecha_creacion: String
    origen_sql: String
  }

  type Review {
    _id: String
    id_product: Int!
    id_user: Int!
    id_people: Int
    titulo: String
    rating: Int!
    comentario: String!
    estado_moderacion: String!
    fecha: String
    activo: Boolean!
    origen_sql: String
  }

  type ShipmentEvent {
    fecha: String
    estado: String
    descripcion: String
    ubicacion: String
  }

  type Shipment {
    _id: String
    id_order: Int!
    id_user: Int!
    id_people: Int!
    tracking_number: String!
    paqueteria: String!
    estado: String!
    fecha_envio: String
    fecha_entrega: String
    ciudad_destino: String
    historial: [ShipmentEvent!]
  }

  type LogEntry {
    _id: String
    fecha_hora: String
    operacion: String!
    usuario: String!
    rol: String!
    ip: String!
    coleccion: String!
    documento_id: String!
    descripcion: String!
    estado: String!
    datos_anteriores: JSONObject
    datos_posteriores: JSONObject
  }

  type RatingSummary {
    id_product: Int!
    promedio_rating: Float!
    total_resenas: Int!
    rating_maximo: Int
    rating_minimo: Int
  }

  type ActiveShipmentView {
    _id: String
    id_order: Int!
    id_user: Int!
    tracking_number: String!
    paqueteria: String!
    estado: String!
    fecha_envio: String
    ciudad_destino: String
    ultimo_evento: ShipmentEvent
  }

  type AddressView {
    _id: String
    id_user: Int!
    id_people: Int!
    nombre_completo: String!
    tipo_direccion: String!
    ciudad: String!
    estado: String!
    codigo_postal: String!
    pais: String!
  }

  type DeleteResult {
    eliminados: Int!
    descripcion: String!
  }

  input AddressInput {
    id_user: Int!
    id_people: Int!
    nombre_completo: String!
    calle: String!
    numero_exterior: String!
    numero_interior: String
    colonia: String!
    ciudad: String!
    estado: String!
    codigo_postal: String!
    pais: String!
    tipo_direccion: String!
  }

  input ReviewInput {
    id_product: Int!
    id_user: Int!
    id_people: Int!
    titulo: String
    rating: Int!
    comentario: String!
  }

  input ShipmentStatusInput {
    id_order: Int!
    estado: String!
    descripcion: String
  }

  type Query {
    # --- Consultas por coleccion (con filtros dinamicos y paginacion) ---
    addresses(idUser: Int, idPeople: Int, activa: Boolean, limit: Int = 20, offset: Int = 0): [Address!]!
    reviews(idProduct: Int, idUser: Int, estado: String, limit: Int = 20, offset: Int = 0): [Review!]!
    shipments(idOrder: Int, estado: String, trackingNumber: String, limit: Int = 20, offset: Int = 0): [Shipment!]!
    logs(operacion: String, usuario: String, limit: Int = 20, offset: Int = 0): [LogEntry!]!

    # --- Consulta optimizada: agregacion + filtros dinamicos + paginacion ---
    productsRatingSummary(minReviews: Int = 1, orden: String = "total_resenas", limit: Int = 20, offset: Int = 0): [RatingSummary!]!

    # --- Las 5 vistas MongoDB ---
    publicReviews(limit: Int = 20, offset: Int = 0): [Review!]!
    activeShipmentsView(limit: Int = 20, offset: Int = 0): [ActiveShipmentView!]!
    userAddressesActiveView(limit: Int = 20, offset: Int = 0): [AddressView!]!
    productsRatingSummaryView(limit: Int = 20, offset: Int = 0): [RatingSummary!]!
    auditLogsRecentView(limit: Int = 20, offset: Int = 0): [LogEntry!]!

    health: String!
  }

  type Mutation {
    createAddress(input: AddressInput!): Address!
    createReview(input: ReviewInput!): Review!
    updateShipmentStatus(input: ShipmentStatusInput!): Shipment!
    moderateReview(idProduct: Int!, idUser: Int!, estado: String!): Review!
    deleteReview(idProduct: Int!, idUser: Int!): DeleteResult!
  }
`;

module.exports = { typeDefs };
