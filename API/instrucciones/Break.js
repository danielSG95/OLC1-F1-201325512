const { Instruccion } = require("../abstract/Instruccion");
const { Type } = require("../symbols/Type");

class Break extends Instruccion {
  constructor(line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    // lo dejo vacio. Solo me sirve para saber si aparece :v
    return {
      value: null,
      type: Type.BREAK,
    };
  }
}

module.exports.Break = Break;
