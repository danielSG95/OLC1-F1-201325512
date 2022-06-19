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

    if (result.type != Type.ERR) {
      let consol = Singleton.getInstance().console;
      consol = consol.concat(result.value);
      Singleton.getInstance().console = consol;
      console.log(`Print dice : '${consol}'`);
    }
  }
}

module.exports.Print = Print;
