// Conexion al driver oficial de MongoDB con reintentos (espera a mongo:7).
const { MongoClient } = require("mongodb");

const uri = process.env.MONGO_URI || "mongodb://127.0.0.1:27017/ecommerce_nosql";
const dbName = process.env.MONGO_DB || "ecommerce_nosql";

let client = null;
let database = null;

async function conectar() {
  const intentos = Number(process.env.MONGO_RETRY || 30);
  const esperaMs = Number(process.env.MONGO_RETRY_DELAY_MS || 2000);
  const timeoutMs = Number(process.env.MONGO_SELECTION_TIMEOUT_MS || 8000);
  for (let i = 1; i <= intentos; i++) {
    try {
      client = new MongoClient(uri, { serverSelectionTimeoutMS: timeoutMs });
      await client.connect();
      // Ping explicito: asegura que mongod ya acepta operaciones antes de servir.
      await client.db("admin").command({ ping: 1 });
      database = client.db(dbName);
      console.log(`[db] Conectado a ${dbName} (intento ${i})`);
      return database;
    } catch (err) {
      console.warn(`[db] Intento ${i}/${intentos} fallido: ${err.message}`);
      if (client) { try { await client.close(); } catch (_) {} client = null; }
      if (i === intentos) throw err;
      await new Promise((resolve) => setTimeout(resolve, esperaMs));
    }
  }
}

function getDb() {
  if (!database) throw new Error("MongoDB no conectado");
  return database;
}

async function cerrar() {
  if (client) await client.close();
}

module.exports = { conectar, getDb, cerrar };
