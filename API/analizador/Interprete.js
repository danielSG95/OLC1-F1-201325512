const parser = require("./analizador");
const { Env } = require("../symbols/Env");
const { Singleton } = require("../singleton/Singleton");
function analizar(text) {
  try {
    let result = parser.parse(text);

    const global = new Env(null);
    result.ast.forEach((element) => {
      try {
        element.ejecutar(global);
      } catch (err) {
        console.error(err);
      }
    });

    if (Singleton.getInstance().errores.length > 1) {
      console.log(Singleton.getInstance().errores);
    }

    return true;
  } catch (err) {
    console.log("se ha encontrado un error");
    console.error(err);
    console.log(Singleton.getInstance().errores);
    return false;
  }
}

module.exports.analizar = analizar;
