const { Instruccion } = require("../abstract/Instruccion");
const { Error } = require("../analizador/Error");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");
const { currentEnv } = require("../symbols/Env");
class Continue extends Instruccion {
  constructor(line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    if (env.typEnv != currentEnv.For) {
      // error
      Singleton.getInstance().errores.push(
        new Error(
          "continue",
          this.line,
          this.column,
          "La instruccion Continue solo puede ejecutarse dentro del ciclo for ",
          "Error Semantico"
        )
      );
      return undefined;
    }

    return {
      value: null,
      type: Type.CONTINUE,
    };
  }
}

module.exports.Continue = Continue;
