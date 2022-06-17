const { Instruccion } = require("../abstract/Instruccion");
const { Aritmetica, AritmeticOp } = require("../expresiones/Aritmetica");
const { Asignacion } = require("./Asignacion");
class Decremento extends Instruccion {
  constructor(name, line, column) {
    super(line, column);
    this.line = line;
    this.column = column;
    this.name;
  }
  ejecutar(env) {
    let asig = new Asignacion(
      this.name,
      new Aritmetica(this.name, 1, AritmeticOp.MENOS, this.line, this.column),
      this.line,
      this.column
    );

    asig.ejecutar(env);
  }
}

module.exports.Decremento = Decremento;
