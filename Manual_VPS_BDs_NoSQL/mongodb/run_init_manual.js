// =============================================================================
// UTXJ - Unidad 2 - run_init_manual.js
// Inicialización/reparación manual de ecommerce_nosql cuando el volumen
// mongo_data_jhon ya existía y Docker omitió /docker-entrypoint-initdb.d.
// =============================================================================
// Ejecutar DENTRO del contenedor (recomendado):
//   docker exec -i mongodb_bitwatt mongosh --quiet \
//     "mongodb://mongo_bitwatt:<PASSWORD>@127.0.0.1:27017/admin?authSource=admin" \
//     --file /docker-entrypoint-initdb.d/run_init_manual.js
//
// Desde el host/PowerShell (scripts locales), indicar la carpeta con:
//   $env:MONGO_SCRIPT_DIR = "C:\ruta\Manual_VPS_BDs_NoSQL\mongodb\"
//   mongosh "mongodb://mongo_bitwatt:<PASSWORD>@5.183.9.45:40085/admin?authSource=admin" \
//     --file .\mongodb\run_init_manual.js
//
// Los 6 scripts son idempotentes: roles/usuarios con updateRole/updateUser,
// colecciones con collMod, semilla con upserts, índices con validación de
// definición, vistas con comparación de pipeline y pruebas con limpieza previa.
// Ningún error de un script aborta los demás: al final se imprime el diagnóstico.
// =============================================================================

const DB_OBJETIVO = "ecommerce_nosql";
const DIR = process.env.MONGO_SCRIPT_DIR || "/docker-entrypoint-initdb.d/";

// Fuerza el contexto correcto ANTES de cargar cualquier script.
db = db.getSiblingDB(DB_OBJETIVO);

const SCRIPTS = [
  "01_users_roles.js",
  "02_collections_schemas.js",
  "03_seed_data.js",
  "04_indexes.js",
  "05_views.js",
  "06_tests_crud.js"
];

const COLECCIONES = ["col_users_adress", "col_products_reviews", "col_shipment_tracking", "col_logs"];
const FUNCIONALES = ["col_users_adress", "col_products_reviews", "col_shipment_tracking"];
const VISTAS = [
  "vw_public_reviews", "vw_active_shipments", "vw_user_addresses_active",
  "vw_products_rating_summary", "vw_audit_logs_recent"
];
const ROLES_ESPERADOS = [
  "log_writer", "superadmin", "admin", "seller", "buyer", "support", "common", "not_registered"
];
const USUARIOS_ESPERADOS = [
  "usr_superadmin", "usr_admin", "usr_seller", "usr_buyer",
  "usr_support", "usr_common", "usr_not_registered"
];

function sep(titulo) {
  print("\n=============================================================");
  print(" " + titulo);
  print("=============================================================");
}

// El entrypoint de mongo:7 ejecuta TODOS los .js de /docker-entrypoint-initdb.d,
// incluido este runner (está en la misma carpeta). Durante initdb NO hay usuario
// autenticado y 01..06 ya corrieron: en ese caso se omite para no duplicar la
// siembra. En una ejecución manual con credenciales root SÍ se ejecuta.
function esInitdb() {
  try {
    const cs = db.adminCommand({ connectionStatus: 1 });
    const autenticados = (cs.authInfo && cs.authInfo.authenticatedUsers) || [];
    return autenticados.length === 0 && !!process.env.MONGO_INITDB_ROOT_USERNAME;
  } catch (e) {
    return false;
  }
}

function main() {

sep("INICIO run_init_manual.js");
print("Base objetivo : " + DB_OBJETIVO);
print("Directorio    : " + DIR);
print("Fecha         : " + new Date().toISOString());

// ---------------------------------------------------------------------------
// 1) Ejecución ordenada de 01..06
// ---------------------------------------------------------------------------
sep("PASO 1/2 - EJECUCION ORDENADA DE LOS 6 SCRIPTS");
let fallos = 0;
SCRIPTS.forEach(function (archivo) {
  print("\n>>> CARGANDO " + archivo);
  try {
    load(DIR + archivo);
    print("<<< FIN " + archivo);
  } catch (e) {
    fallos++;
    print("<<< ERROR EN " + archivo + ": " + (e.message || String(e)));
    print("    Se continúa con los demás scripts para completar el diagnóstico.");
  }
});

// La sesión puede haber cambiado de usuario dentro de 06_tests_crud.js.
db = db.getSiblingDB(DB_OBJETIVO);

// ---------------------------------------------------------------------------
// 2) Diagnóstico completo
// ---------------------------------------------------------------------------
sep("PASO 2/2 - DIAGNOSTICO FINAL DE " + DB_OBJETIVO);

// --- 2.1 listDatabases -------------------------------------------------------
print("\n-- db.adminCommand({ listDatabases: 1 }) --");
let presente = false;
try {
  const respuesta = db.adminCommand({ listDatabases: 1 });
  const bases = respuesta.databases || [];
  bases.forEach(function (bd) {
    print("   " + bd.name + " : " + bd.sizeOnDisk + " bytes");
  });
  const destino = bases.filter(function (bd) { return bd.name === DB_OBJETIVO; })[0];
  presente = !!destino && destino.sizeOnDisk > 0;
  print("   RESULTADO: " + DB_OBJETIVO +
        (destino ? " PRESENTE (sizeOnDisk=" + destino.sizeOnDisk + ")" : " AUSENTE") +
        "  -> " + (presente ? "OK (tamaño > 0)" : "REVISION REQUERIDA"));
} catch (e) {
  print("   [ERROR listDatabases] " + (e.message || String(e)));
}

// --- 2.2 getCollectionNames (colecciones + vistas) ---------------------------
print("\n-- db.getCollectionNames() --");
let nombres = [];
try {
  nombres = db.getCollectionNames();
  nombres.slice().sort().forEach(function (n) { print("   " + n); });
} catch (e) {
  print("   [ERROR getCollectionNames] " + (e.message || String(e)));
}
COLECCIONES.forEach(function (c) {
  print("   coleccion " + c + ": " + (nombres.indexOf(c) !== -1 ? "PRESENTE" : "FALTA"));
});
VISTAS.forEach(function (v) {
  print("   vista     " + v + ": " + (nombres.indexOf(v) !== -1 ? "PRESENTE" : "FALTA"));
});

// --- 2.3 countDocuments ------------------------------------------------------
print("\n-- countDocuments() --");
COLECCIONES.forEach(function (c) {
  try {
    const n = db.getCollection(c).countDocuments({});
    const marca = FUNCIONALES.indexOf(c) !== -1
      ? (n >= 12 ? "OK (>=12 documentos reales)" : "ALERTA: se esperaban >=12")
      : "OK (bitácora de operaciones reales)";
    print("   " + c + ": " + n + "  -> " + marca);
  } catch (e) {
    print("   " + c + ": [ERROR] " + (e.message || String(e)));
  }
});
VISTAS.forEach(function (v) {
  try {
    print("   " + v + ": " + db.getCollection(v).countDocuments({}) + " documentos");
  } catch (e) {
    print("   " + v + ": [ERROR] " + (e.message || String(e)));
  }
});

// --- 2.4 getRoles con privilegios -------------------------------------------
print("\n-- db.getRoles({ showPrivileges: true }) --");
try {
  const respuestaRoles = db.getRoles({ rolesInfo: 1, showPrivileges: true, showBuiltinRoles: false });
  const roles = Array.isArray(respuestaRoles) ? respuestaRoles : (respuestaRoles.roles || []);
  print("   TOTAL roles personalizados: " + roles.length +
        " (7 e-commerce + log_writer)");
  roles.slice().sort(function (a, b) { return a.role.localeCompare(b.role); }).forEach(function (rol) {
    print("   - " + rol.role + " | privilegios=" + (rol.privileges || []).length +
          " | heredados=" + (rol.roles || []).length);
  });
  const nombresRoles = roles.map(function (rol) { return rol.role; });
  ROLES_ESPERADOS.forEach(function (esperado) {
    print("   rol " + esperado + ": " +
          (nombresRoles.indexOf(esperado) !== -1 ? "PRESENTE" : "FALTA"));
  });
} catch (e) {
  print("   [ERROR getRoles] " + (e.message || String(e)));
}

// --- 2.5 getUsers ------------------------------------------------------------
print("\n-- db.getUsers() --");
try {
  const respuestaUsuarios = db.getUsers();
  const usuarios = Array.isArray(respuestaUsuarios) ? respuestaUsuarios : (respuestaUsuarios.users || []);
  print("   TOTAL usuarios: " + usuarios.length);
  usuarios.slice().sort(function (a, b) { return a.user.localeCompare(b.user); }).forEach(function (u) {
    const susRoles = (u.roles || []).map(function (x) { return x.role; }).join(", ");
    print("   - " + u.user + " -> " + susRoles);
  });
  const nombresUsuarios = usuarios.map(function (u) { return u.user; });
  USUARIOS_ESPERADOS.forEach(function (esperado) {
    print("   usuario " + esperado + ": " +
          (nombresUsuarios.indexOf(esperado) !== -1 ? "PRESENTE" : "FALTA"));
  });
} catch (e) {
  print("   [ERROR getUsers] " + (e.message || String(e)));
}

sep("FIN run_init_manual.js  |  scripts con error=" + fallos +
    "  |  " + DB_OBJETIVO + (presente ? " OK" : " REVISAR"));

}

if (esInitdb()) {
  print("run_init_manual.js: omitido durante initdb (los scripts 01..06 ya se ejecutaron).");
  print("Para forzar la reparación manual, ejecútalo con docker exec y credenciales root.");
} else {
  main();
}
