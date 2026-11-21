const { GraphQLScalarType, Kind } = require("graphql");

// Escalar generico para los campos datos_anteriores / datos_posteriores de col_logs.
const JSONObject = new GraphQLScalarType({
  name: "JSONObject",
  description: "Objeto JSON arbitrario usado en la auditoria",
  serialize: (value) => value,
  parseValue: (value) => value,
  parseLiteral: (ast) => {
    function leer(node) {
      switch (node.kind) {
        case Kind.STRING:
        case Kind.BOOLEAN:
          return node.value;
        case Kind.INT:
          return parseInt(node.value, 10);
        case Kind.FLOAT:
          return parseFloat(node.value);
        case Kind.NULL:
          return null;
        case Kind.LIST:
          return node.values.map(leer);
        case Kind.OBJECT:
          return node.fields.reduce((acc, f) => { acc[f.name.value] = leer(f.value); return acc; }, {});
        default:
          return null;
      }
    }
    return leer(ast);
  }
});

module.exports = { JSONObject };
