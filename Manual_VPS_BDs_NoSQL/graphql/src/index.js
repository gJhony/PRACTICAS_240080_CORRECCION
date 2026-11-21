// API GraphQL - UTXJ Unidad 2 (Indicadores 11, 15, 47, 48, 49)
// Apollo Server 3 + Express + driver oficial de MongoDB.
// Headers de contexto: x-user, x-role, x-forwarded-for, x-request-id.
const express = require("express");
const { ApolloServer } = require("apollo-server-express");
const { typeDefs } = require("./schema");
const { resolvers } = require("./resolvers");
const { conectar, getDb, cerrar } = require("./db");
const { normalizarRol } = require("./roles");

async function iniciar() {
  await conectar();

  const app = express();
  app.disable("x-powered-by");

  app.get("/health", (_req, res) => {
    res.status(200).json({
      status: "ok",
      service: "graphql_jhon",
      database: process.env.MONGO_DB || "ecommerce_nosql",
      port: Number(process.env.PORT || 40087)
    });
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
  server.applyMiddleware({ app, path: "/graphql", cors: true });

  const port = Number(process.env.PORT || 40087);
  const httpServer = app.listen(port, "0.0.0.0", () => {
    console.log(`[graphql_jhon] API lista en http://0.0.0.0:${port}/graphql`);
    console.log("[graphql_jhon] headers: x-user, x-role, x-forwarded-for");
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
