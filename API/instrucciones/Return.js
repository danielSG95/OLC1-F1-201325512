const { Instruccion } = require("../abstract/Instruccion");
const { Type } = require("../symbols/Type");
const { currentEnv } = require("../symbols/Env");
const { Singleton } = require("../singleton/Singleton");
const { Error } = require("../analizador/Error");
class Return extends Instruccion {
  constructor(exp, line, column) {
    super(line, column);
    this.exp = exp;
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    if (
      env.typEnv != currentEnv.Funcion &&
      env.typEnv != currentEnv.Ciclo &&
      env.typEnv != currentEnv.For
    ) {
      Singleton.getInstance().errores.push(
        new Error(
          "return",
          this.line,
          this.column,
          "La instruccion Return solo puede ejecutarse dentro de un Ciclo o una Funcion  ",
          "Error Semantico"
        )
      );
      return undefined;
    }
    if (this.exp == null) {
      return { value: null, type: Type.NULL };
    }
    let result = this.exp.ejecutar(env);

    return result;

    /**
     *  return a > b; true | false
     */
  }
}

module.exports.Return = Return;
