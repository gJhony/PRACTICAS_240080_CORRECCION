// Matriz de permisos de los 7 roles e-commerce (Indicadores 24, 47, 48).
// Se aplica en la capa GraphQL; MongoDB ademas refuerza con roles de BD.

const ROLES = [
  "superadmin", "admin", "seller", "buyer", "support", "common", "not_registered"
];

const C = {
  ADDRESS: "col_users_adress",
  REVIEWS: "col_products_reviews",
  SHIPMENTS: "col_shipment_tracking",
  LOGS: "col_logs",
  V_PUBLIC: "vw_public_reviews",
  V_SHIP: "vw_active_shipments",
  V_ADDR: "vw_user_addresses_active",
  V_RATING: "vw_products_rating_summary",
  V_AUDIT: "vw_audit_logs_recent"
};

// Operaciones: CREATE | READ | UPDATE | DELETE
const MATRIZ = {
  superadmin: { "*": ["CREATE", "READ", "UPDATE", "DELETE"] },
  admin: { "*": ["CREATE", "READ", "UPDATE", "DELETE"] },
  seller: {
    [C.ADDRESS]: ["READ"],
    [C.REVIEWS]: ["CREATE", "READ", "UPDATE"],
    [C.SHIPMENTS]: ["READ", "UPDATE"],
    [C.LOGS]: ["CREATE"],
    [C.V_PUBLIC]: ["READ"], [C.V_SHIP]: ["READ"], [C.V_ADDR]: ["READ"], [C.V_RATING]: ["READ"]
  },
  buyer: {
    [C.ADDRESS]: ["CREATE", "READ", "UPDATE"],
    [C.REVIEWS]: ["CREATE", "READ"],
    [C.SHIPMENTS]: ["READ"],
    [C.LOGS]: ["CREATE"],
    [C.V_PUBLIC]: ["READ"], [C.V_SHIP]: ["READ"], [C.V_RATING]: ["READ"]
  },
  support: {
    [C.ADDRESS]: ["READ"],
    [C.REVIEWS]: ["READ", "UPDATE"],
    [C.SHIPMENTS]: ["READ", "UPDATE"],
    [C.LOGS]: ["CREATE", "READ"],
    [C.V_PUBLIC]: ["READ"], [C.V_SHIP]: ["READ"], [C.V_ADDR]: ["READ"],
    [C.V_RATING]: ["READ"], [C.V_AUDIT]: ["READ"]
  },
  common: {
    [C.ADDRESS]: ["CREATE", "READ", "UPDATE"],
    [C.LOGS]: ["CREATE"],
    [C.V_PUBLIC]: ["READ"], [C.V_SHIP]: ["READ"], [C.V_RATING]: ["READ"]
  },
  not_registered: {
    [C.V_PUBLIC]: ["READ"]
  }
};

function normalizarRol(rol) {
  const r = String(rol || "not_registered").trim().toLowerCase();
  return ROLES.indexOf(r) !== -1 ? r : "not_registered";
}

function autorizado(rol, operacion, recurso) {
  const permisos = MATRIZ[normalizarRol(rol)] || {};
  const op = String(operacion).toUpperCase();
  if (permisos["*"] && permisos["*"].indexOf(op) !== -1) return true;
  const expl = permisos[recurso] || [];
  return expl.indexOf(op) !== -1;
}

module.exports = { ROLES, C, normalizarRol, autorizado };
