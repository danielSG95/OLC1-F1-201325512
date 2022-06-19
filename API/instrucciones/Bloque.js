const { Instruccion } = require("../abstract/Instruccion");
const { Env, currentEnv } = require("../symbols/Env");
const { Funcion } = require("../instrucciones/Funcion");

class Bloque extends Instruccion {
  constructor(linstrucciones, line, column) {
    super(line, column);

    this.line = line;
    this.column = column;
    this.linstrucciones = linstrucciones;
  }

  ejecutar(env) {
    if (this.linstrucciones == undefined) {
      return undefined;
    }
    const newEnv = new Env(env, currentEnv.Bloque);
    // algo
    try {
      // ejecuto funcion para poder guardarla en la tabla de simbolos
      for (const e of this.linstrucciones) {
        if (e instanceof Funcion) {
          e.ejecutar(newEnv);
        }
      }
      // ejecuto todo lo que no sea funcion
      for (const e of this.linstrucciones) {
        if (!(e instanceof Funcion)) {
          e.ejecutar(newEnv);
        }
      }
    } catch (error) {
      console.log(error);
    }
  }
}

module.exports.Bloque = Bloque;
