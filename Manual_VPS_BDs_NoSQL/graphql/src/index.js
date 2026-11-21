// API GraphQL - UTXJ Unidad 2 (Indicadores 11, 15, 47, 48, 49)
// Apollo Server 3 + Express + driver oficial de MongoDB.
// Headers de contexto: x-user, x-role, x-forwarded-for, x-request-id.
const express = require("express");
const cors = require("cors");
const { ApolloServer } = require("apollo-server-express");
const { typeDefs } = require("./schema");
const { resolvers } = require("./resolvers");
const { conectar, getDb, cerrar } = require("./db");
const { normalizarRol } = require("./roles");

const HOST = process.env.HOST || "0.0.0.0";
const PORT = Number(process.env.PORT || 40087);
const GRAPHQL_PATH = "/graphql";

// CORS explicito: Studio (https) y el propio VPS (http) pueden consultar la API.
const corsOptions = {
  origin: "*",
  methods: ["GET", "POST", "OPTIONS"],
  allowedHeaders: [
    "Content-Type",
    "Accept",
    "x-user",
    "x-role",
    "x-forwarded-for",
    "x-request-id",
    "apollographql-client-name",
    "apollographql-client-version"
  ],
  optionsSuccessStatus: 204
};

async function iniciar() {
  await conectar();

  const app = express();
  app.disable("x-powered-by");

  // Cubre /, /health y /graphql; el header privado ayuda a Chrome 142+ con LNA.
  app.use((_req, res, next) => {
    res.setHeader("Access-Control-Allow-Private-Network", "true");
    next();
  });
  app.use(cors(corsOptions));

  app.get("/health", (_req, res) => {
    res.status(200).json({
      status: "ok",
      service: "graphql_jhon",
      database: process.env.MONGO_DB || "ecommerce_nosql",
      port: PORT
    });
  });

  // El servidor responde tambien en / (pagina de aterrizaje de la API).
  app.get("/", (_req, res) => {
    res.status(200).type("html").send(
      "<!doctype html><html lang='es'><head><meta charset='utf-8'>" +
      "<title>graphql_jhon</title></head><body>" +
      "<h1>graphql_jhon</h1>" +
      "<p>API GraphQL sobre MongoDB <code>ecommerce_nosql</code>.</p>" +
      "<ul>" +
      "<li><a href='/health'>/health</a></li>" +
      "<li><a href='/graphql'>/graphql</a></li>" +
      "</ul>" +
      "<p>Headers de contexto: x-user, x-role, x-forwarded-for, x-request-id.</p>" +
      "</body></html>"
    );
  });

  // Alias: POST / se atiende como POST /graphql (ambas rutas responden GraphQL).
  app.use((req, _res, next) => {
    if (req.method === "POST" && req.path === "/") {
      const query = req.url.includes("?") ? req.url.slice(req.url.indexOf("?")) : "";
      req.url = GRAPHQL_PATH + query;
    }
    next();
  });

  const server = new ApolloServer({
    typeDefs,
    resolvers,
    introspection: true,
    context: ({ req }) => {
      const forwarded = String(req.headers["x-forwarded-for"] || "");
      return {
        user: String(req.headers["x-user"] || "anonimo"),
        role: normalizarRol(req.headers["x-role"] || "not_registered"),
        ip: forwarded.split(",")[0].trim() || req.socket.remoteAddress || "0.0.0.0",
        requestId: req.headers["x-request-id"] || undefined,
        db: getDb()
      };
    },
    formatError: (formatted, error) => {
      console.warn("[graphql]", formatted.message);
      if (error && error.extensions && error.extensions.code) {
        formatted.extensions = { ...formatted.extensions, code: error.extensions.code };
      }
      // No exponer stack traces al cliente (buffers / rutas del servidor).
      if (formatted.extensions && formatted.extensions.exception) {
        delete formatted.extensions.exception;
      }
      return formatted;
    }
  });

  await server.start();
  server.applyMiddleware({ app, path: GRAPHQL_PATH, cors: corsOptions });

  const httpServer = app.listen(PORT, HOST, () => {
    console.log(`[graphql_jhon] API lista en http://${HOST}:${PORT}${GRAPHQL_PATH}`);
    console.log(`[graphql_jhon] tambien disponible en http://${HOST}:${PORT}/`);
    console.log("[graphql_jhon] CORS: * | headers: x-user, x-role, x-forwarded-for, x-request-id");
  });

  async function apagar() {
    httpServer.close();
    await server.stop();
    await cerrar();
    process.exit(0);
  }
  process.on("SIGTERM", apagar);
  process.on("SIGINT", apagar);
}

iniciar().catch((err) => {
  console.error("[graphql_jhon] No se pudo iniciar:", err);
  process.exit(1);
});
