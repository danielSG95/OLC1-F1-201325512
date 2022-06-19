const { Instruccion } = require("../abstract/Instruccion");

class Funcion extends Instruccion {
  constructor(name, type, lParametros, lInstrucciones, line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
    this.lArgs = lParametros;
    this.lInstrucciones = lInstrucciones;
    this.type = type;
    this.name = name;
  }

  ejecutar(env) {
    console.log("definiendo una funcion");
    env.insertFuncion(this.name, this);
  }
}

module.exports.Funcion = Funcion;
