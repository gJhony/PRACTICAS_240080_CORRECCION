const http = require("http");

const port = process.env.GRAPHQL_PORT || 40087;
const mongoUri = process.env.MONGO_URI || "";

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "application/json" });
  res.end(
    JSON.stringify({
      status: "ok",
      service: "graphql",
      port,
      hasMongoUri: Boolean(mongoUri)
    })
  );
});

server.listen(port, "0.0.0.0", () => {
  console.log(`GraphQL placeholder running on port ${port}`);
});