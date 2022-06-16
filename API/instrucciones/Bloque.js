const { Instruccion } = require("../abstract/Instruccion");
const { Env } = require("../symbols/Env");

class Bloque extends Instruccion {
  constructor(linstrucciones, line, column) {
    super(line, column);

    this.line = line;
    this.column = column;
    this.linstrucciones = linstrucciones;
  }

  ejecutar(env) {
    const newEnv = new Env(env);
    // algo
    for (const e of this.linstrucciones) {
      try {
        e.ejecutar(newEnv);
      } catch (err) {
        console.error(err);
      }
    }
  }
}

module.exports.Bloque = Bloque;
