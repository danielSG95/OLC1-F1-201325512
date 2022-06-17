const { Instruccion } = require("../abstract/Instruccion");
const { Env } = require("../symbols/Env");
const { Return } = require("./Return");

class If extends Instruccion {
  constructor(expresion, bloqueSi, bloqueNo, rIf, line, column) {
    super(line, column);
    this.expresion = expresion;
    this.bloqueNo = bloqueNo;
    this.bloqueSi = bloqueSi;
    this.rIf = rIf;
    this.line = line;
    this.column = column;
  }
  ejecutar(env) {
    let result = this.expresion.ejecutar(env); // me quiero suscribir al cambio que pueda sufrir esta variable.
    if (result.value) {
      let newEnv = new Env(env);
      for (const iterator of this.bloqueSi) {
        let r = iterator.ejecutar(newEnv);
        if (r != undefined) {
          if (r.type == Type.BREAK) {
            return; // aqui hago un return sin mas.
          } else if (r.type == Type.CONTINUE) {
            continue; // aqui necesito llamar a continue
          } else {
            return r; // aqui estoy devolviendo un tipo de dato.
          }
        }
      }
    } else {
      // el bloqueNo se ejecuta solo sino se cumple ninguna otra condicion.
      if (this.rIf != null || this.rIf != undefined) {
        this.rIf.ejecutar(env); // para ver si este if cumplio la condicion.
      }

      if (this.bloqueNo) {
        let newEnv = new Env(env);
        for (const iterator of this.bloqueNo) {
          iterator.ejecutar(newEnv); // esto es un nuevo env
        }
      }
    }
  }
}

module.exports.If = If;
