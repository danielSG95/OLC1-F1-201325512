const { Instruccion } = require("../abstract/Instruccion");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");

class Print extends Instruccion {
  constructor(expresion, line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
    this.expresion = expresion;
  }

  ejecutar(env) {
    let result = this.expresion.ejecutar(env);
    let text = "";
    if (result.type == Type.ERR) {
      return undefined;
    }

    text = result.value;
    if (result.type == Type.ARRAY) {
      // aqui debo de generar el array
      text = this.outputArray(result.value);
    } else if (result.type == Type.MATRIX) {
    }

    let consol = Singleton.getInstance().console;
    consol = consol.concat(text);
    Singleton.getInstance().console = consol;
    console.log(`Print dice : '${consol}'`);
  }

  outputArray(val) {
    let salida = "[";

    for (let i = 0; i < val.value.length; i++) {
      if (i == 0) {
        salida += val.value[i];
        continue;
      }

      salida += "," + val.value[i];
    }
    salida += "]";

    return salida;
  }
}

module.exports.Print = Print;
