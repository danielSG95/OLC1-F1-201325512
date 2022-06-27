const parser = require("./analizador");
const { Env, currentEnv } = require("../symbols/Env");
const { Singleton } = require("../singleton/Singleton");
const { Funcion } = require("../instrucciones/Funcion");
const { Grafo } = require("../ast/Grafo");
const response = {
  foundFatalErrors: false,
  res: undefined,
};

async function analizar(text) {
  let consola = "";
  let errores = "";
  try {
    let result = parser.parse(text);

    if (result.ast == undefined || null) {
      throw new TypeError("No input provided to the parser");
    }
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

    consola = Singleton.getInstance().console;
    errores = Singleton.getInstance().errores;
    response.foundFatalErrors = false;
    response.res = {
      consola: consola,
      errores: errores,
    };
  } catch (err) {
    console.log(err);
    console.log(Singleton.getInstance().errores);
    response.foundFatalErrors = true;
    response.res = {
      consola: consola,
      errores: errores,
    };
  }

  return response;
}

module.exports.analizar = analizar;
