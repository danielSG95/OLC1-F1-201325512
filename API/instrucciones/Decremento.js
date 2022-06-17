const { Instruccion } = require("../abstract/Instruccion");
const { Type } = require("../symbols/Type");
class Decremento extends Instruccion {
  constructor(name, line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
    this.name = name.value;
  }
  ejecutar(env) {
    let symbol = env.buscarVariable(this.name);
    let isValid = true;
    if (symbol != null) {
      // la variable existe
      if (
        symbol.type != Type.NUMBER &&
        symbol.type != Type.DECIMAL &&
        symbol.type != Type.CHAR
      ) {
        // error
        isValid = false;
      }

      if (isValid && !symbol.isConstant) {
        symbol.value -= 1;
        console.log(env.getEnv());
      }
    }
  }
}

module.exports.Decremento = Decremento;
