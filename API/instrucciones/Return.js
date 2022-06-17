const { Instruccion } = require("../abstract/Instruccion");

class Return extends Instruccion {
  constructor(exp, line, column) {
    super(line, column);
    this.exp = exp;
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    if (this.exp == null) {
      return null;
    }
    let result = this.exp.ejecutar(env);

    return result;

    /**
     *  return a > b; true | false
     */
  }
}

module.exports.Return = Return;
