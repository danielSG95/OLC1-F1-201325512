const { Instruccion } = require("../abstract/Instruccion");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");

class Println extends Instruccion {
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
      text = this.outputArray(result.value);
    } else if (result.type == Type.MATRIX) {
    }

    let consol = Singleton.getInstance().console;
    consol = consol.concat(text + "\n");
    Singleton.getInstance().console = consol;
    console.log(`Println dice :'${consol}'`);
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

module.exports.Println = Println;
