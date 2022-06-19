const { Instruccion } = require("../abstract/Instruccion");
const { Type } = require("../symbols/Type");
const { currentEnv } = require("../symbols/Env");
const { Error } = require("../analizador/Error");
const { Singleton } = require("../singleton/Singleton");
class Break extends Instruccion {
  constructor(line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    // lo dejo vacio. Solo me sirve para saber si aparece :v
    if (
      env.typEnv != currentEnv.Ciclo &&
      env.typEnv != currentEnv.Switch &&
      env.typEnv != currentEnv.If &&
      env.typEnv != currentEnv.For
    ) {
      Singleton.getInstance().errores.push(
        new Error(
          "break",
          this.line,
          this.column,
          "La instruccion Break solo puede ejecutarse dentro de un Ciclo o un bloque Switch-Case ",
          "Error Semantico"
        )
      );
      return undefined;
    }
    return {
      value: null,
      type: Type.BREAK,
    };
  }
}

module.exports.Break = Break;
