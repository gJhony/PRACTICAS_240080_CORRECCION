// =============================================================================
// UTXJ - Unidad 2 - Apartado D (Indicadores 20-29)
// 01_users_roles.js - Modelo de seguridad: 7 roles e-commerce + 7 cuentas
// =============================================================================
// Se ejecuta automaticamente en /docker-entrypoint-initdb.d (mongo:7) y tambien
// manualmente:  mongosh "mongodb://<root>:<pwd>@5.183.9.45:40085/admin" --file 01_users_roles.js
// Las contrasenas se leen de variables de entorno; NO hay secretos en el repo.
// =============================================================================

db = db.getSiblingDB("ecommerce_nosql");
const DB = "ecommerce_nosql";

function pass(envName, placeholder) {
  const value = process.env[envName];
  if (!value) {
    print("  [AVISO] " + envName + " no definida; se usa placeholder de ejemplo. NO usar en produccion.");
    return placeholder;
  }
  return value;
}

// Si la variable NO vino en el entorno, un usuario ya existente conserva su
// contraseña real: updateUser solo recibe { roles }. Así una re-ejecucion manual
// nunca deja fuera a Compass ni al middleware GraphQL.
function passDefinida(envName) { return !!process.env[envName]; }

function upsertRole(name, privileges, roles, descripcion) {
  // getRole() devuelve null cuando no existe (NO lanza excepcion): hace falta
  // el else explicito, de lo contrario el rol nunca se creaba en initdb.
  let existente = null;
  try { existente = db.getRole(name); } catch (e) { existente = null; }
  if (existente) {
    db.updateRole(name, { privileges: privileges, roles: roles });
    print("  [OK] Rol actualizado: " + name);
  } else {
    // MongoDB 7 no acepta el campo description en createRole; la descripcion
    // queda documentada en este archivo y en el README del proyecto.
    db.createRole({
      role: name,
      privileges: privileges,
      roles: roles
    });
    print("  [OK] Rol creado: " + name + " (" + descripcion + ")");
  }
}

function upsertUser(user, pwd, roles, definida) {
  // Igual que getRole(): getUser() devuelve null cuando no existe.
  let existente = null;
  try { existente = db.getUser(user); } catch (e) { existente = null; }
  if (existente) {
    const cambios = { roles: roles };
    if (definida) cambios.pwd = pwd;
    db.updateUser(user, cambios);
    print("  [OK] Usuario actualizado: " + user + (definida ? " (password rotada)" : " (password conservada)"));
  } else {
    db.createUser({ user: user, pwd: pwd, roles: roles });
    print("  [OK] Usuario creado: " + user);
  }
}

const p = (collection, actions) => ({
  resource: { db: DB, collection: collection },
  actions: actions
});
const r = (role, dbName) => ({ role: role, db: dbName || DB });

print("== Apartado D: creando roles personalizados en " + DB + " ==");

// Rol auxiliar de trazabilidad: SOLO insertar en col_logs (no puede leer/borrar).
// Lo heredan los roles que pueden escribir, para que TODA operacion quede registrada.
upsertRole(
  "log_writer",
  [p("col_logs", ["insert"])],
  [],
  "Helper de auditoria: permite insertar evidencia real en col_logs"
);

// 1) superadmin: control total de la BD (lectura, escritura, administracion y usuarios).
upsertRole(
  "superadmin",
  [],
  [r("readWrite"), r("dbAdmin"), r("userAdmin")],
  "Control total de ecommerce_nosql, incluidos usuarios y roles"
);

// 2) admin: lectura/escritura en todas las colecciones y vistas + auditoria.
upsertRole(
  "admin",
  [],
  [r("readWrite"), r("log_writer")],
  "Administracion operativa: CRUD completo y lectura de logs"
);

// 3) seller: gestiona resenas y seguimiento; lee direcciones y vistas. No borra.
upsertRole(
  "seller",
  [
    p("col_users_adress", ["find"]),
    p("col_products_reviews", ["find", "insert", "update"]),
    p("col_shipment_tracking", ["find", "update"]),
    p("vw_public_reviews", ["find"]),
    p("vw_active_shipments", ["find"]),
    p("vw_user_addresses_active", ["find"]),
    p("vw_products_rating_summary", ["find"])
  ],
  [r("log_writer")],
  "Vendedor: publica/edita resenas, actualiza envios, lee direcciones"
);

// 4) buyer: administra sus direcciones, reseña productos y consulta sus envios.
upsertRole(
  "buyer",
  [
    p("col_users_adress", ["find", "insert", "update"]),
    p("col_products_reviews", ["find", "insert"]),
    p("col_shipment_tracking", ["find"]),
    p("vw_public_reviews", ["find"]),
    p("vw_active_shipments", ["find"]),
    p("vw_products_rating_summary", ["find"])
  ],
  [r("log_writer")],
  "Comprador: direcciones propias, crear resenas, consultar envios"
);

// 5) support: lee todo, puede moderar resenas y cambiar estatus de envio. No borra.
upsertRole(
  "support",
  [
    p("col_users_adress", ["find"]),
    p("col_products_reviews", ["find", "update"]),
    p("col_shipment_tracking", ["find", "update"]),
    p("vw_public_reviews", ["find"]),
    p("vw_active_shipments", ["find"]),
    p("vw_user_addresses_active", ["find"]),
    p("vw_products_rating_summary", ["find"]),
    p("vw_audit_logs_recent", ["find"]),
    p("col_logs", ["find"])
  ],
  [r("log_writer")],
  "Soporte: lectura total, moderacion y actualizacion de estatus"
);

// 6) common: usuario registrado sin permisos de compra; solo sus direcciones
//    y las vistas publicas. No puede leer la coleccion cruda de resenas.
upsertRole(
  "common",
  [
    p("col_users_adress", ["find", "insert", "update"]),
    p("vw_public_reviews", ["find"]),
    p("vw_products_rating_summary", ["find"]),
    p("vw_active_shipments", ["find"])
  ],
  [r("log_writer")],
  "Usuario comun: vistas publicas y direcciones propias"
);

// 7) not_registered: visitante. UNICAMENTE puede leer la vista publica
//    autorizada. Cualquier acceso a colecciones protegidas debe ser DENEGADO.
upsertRole(
  "not_registered",
  [p("vw_public_reviews", ["find"])],
  [],
  "Visitante: solo lectura de vw_public_reviews; sin acceso a datos protegidos"
);

print("== Creando una cuenta por rol ==");
upsertUser("usr_superadmin", pass("MONGO_USR_SUPERADMIN_PASSWORD", "CAMBIAR_CLAVE_SUPERADMIN"), [r("superadmin")], passDefinida("MONGO_USR_SUPERADMIN_PASSWORD"));
upsertUser("usr_admin", pass("MONGO_USR_ADMIN_PASSWORD", "CAMBIAR_CLAVE_ADMIN"), [r("admin")], passDefinida("MONGO_USR_ADMIN_PASSWORD"));
upsertUser("usr_seller", pass("MONGO_USR_SELLER_PASSWORD", "CAMBIAR_CLAVE_SELLER"), [r("seller")], passDefinida("MONGO_USR_SELLER_PASSWORD"));
upsertUser("usr_buyer", pass("MONGO_USR_BUYER_PASSWORD", "CAMBIAR_CLAVE_BUYER"), [r("buyer")], passDefinida("MONGO_USR_BUYER_PASSWORD"));
upsertUser("usr_support", pass("MONGO_USR_SUPPORT_PASSWORD", "CAMBIAR_CLAVE_SUPPORT"), [r("support")], passDefinida("MONGO_USR_SUPPORT_PASSWORD"));
upsertUser("usr_common", pass("MONGO_USR_COMMON_PASSWORD", "CAMBIAR_CLAVE_COMMON"), [r("common")], passDefinida("MONGO_USR_COMMON_PASSWORD"));
upsertUser("usr_not_registered", pass("MONGO_USR_NOT_REGISTERED_PASSWORD", "CAMBIAR_CLAVE_NOT_REGISTERED"), [r("not_registered")], passDefinida("MONGO_USR_NOT_REGISTERED_PASSWORD"));

print("== Resumen de roles ==");
// mongosh 2.x devuelve { roles: [...], ok: 1 }, no un array directo.
const resumenRoles = db.getRoles({ rolesInfo: 1, showPrivileges: false });
const listaRoles = Array.isArray(resumenRoles) ? resumenRoles : (resumenRoles.roles || []);
listaRoles.forEach(function (role) {
  const heredados = Array.isArray(role.roles) ? role.roles.length : 0;
  print("  - " + role.role + " (" + heredados + " roles heredados)");
});
print("== Fin 01_users_roles.js ==");
