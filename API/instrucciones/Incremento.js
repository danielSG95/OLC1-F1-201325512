const { Instruccion } = require("../abstract/Instruccion");
const { Aritmetica, AritmeticOp } = require("../expresiones/Aritmetica");
const { Literal } = require("../expresiones/Literal");
const { Type } = require("../symbols/Type");
const { Asignacion } = require("./Asignacion");
const { Typeof } = require("./Typeof");

class Incremento extends Instruccion {
  constructor(lit, line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
    this.name = lit.value;
  }
  ejecutar(env) {
    // buscar la variable

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
        symbol.value += 1;
        console.log(env.getEnv());
      }
    }
  }
}

module.exports.Incremento = Incremento;
