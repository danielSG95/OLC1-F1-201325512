const { Instruccion } = require("../abstract/Instruccion");

class For extends Instruccion {
  constructor(
    declaracion,
    condicion,
    incremento,
    linstrucciones,
    line,
    column
  ) {
    super(line, columna);
    this.declaracion = declaracion;
    this.condicion = condicion;
    this.incremento = incremento;
    this.linstrucciones = linstrucciones;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    // algo
  }
}

module.exports.For = For;
