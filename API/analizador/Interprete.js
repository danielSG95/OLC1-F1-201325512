const parser = require("./analizador");
const { Env, currentEnv } = require("../symbols/Env");
const { Singleton } = require("../singleton/Singleton");
const { Funcion } = require("../instrucciones/Funcion");
function analizar(text) {
  try {
    let result = parser.parse(text);

    const global = new Env(null, currentEnv.Global);
    // en la 1er pasada se debe de ejecutar solo las instrucciones de tipo funcion

    result.ast.forEach((element) => {
      if (element instanceof Funcion) {
        element.ejecutar(global);
      }
    });

    // en la segunda pasada opero todo lo demas.

    result.ast.forEach((element) => {
      if (!(element instanceof Funcion)) {
        element.ejecutar(global);
      }
    });

    if (Singleton.getInstance().errores.length > 0) {
      console.log(Singleton.getInstance().errores);
    }

    let consola = Singleton.getInstance().console;
    console.log(consola);
    return { consola: consola, errores: Singleton.getInstance().errores };
    //return true;
  } catch (err) {
    console.log(Singleton.getInstance().errores);
    return false;
  }
}

module.exports.analizar = analizar;
