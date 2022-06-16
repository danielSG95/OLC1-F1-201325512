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

    if (result.type != Type.ERR) {
      let consol = Singleton.getInstance().console;
      consol = consol.concat(result.value + "\n");
      console.log(`Println dice :'${consol}'`);
    }
  }
}

module.exports.Println = Println;
