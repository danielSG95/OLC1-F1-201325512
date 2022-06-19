const { Instruccion } = require("../abstract/Instruccion");

class Switch extends Instruccion {
  constructor(condicion, lCase, line, column) {
    super(line, column);
    this.condicion = condicion;
    this.lCase = lCase;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    // ejecutar aqui
    console.log("switch aqui ");
  }
}

class Case {
  constructor(dato, lInstrucciones, iDefault) {
    this.dato = dato;
    this.lInstrucciones = lInstrucciones;
    this.iDefault = iDefault;
  }
}

module.exports.Switch = Switch;
module.exports.Case = Case;
