const { Instruccion } = require("../abstract/Instruccion");
const { Env, currentEnv } = require("../symbols/Env");
const { Type } = require("../symbols/Type");

class DoWhile extends Instruccion {
  constructor(expresion, linstrucciones, line, column) {
    super(line, column);
    this.expresion = expresion;
    this.linstrucciones = linstrucciones;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    let newEnv = new Env(env, currentEnv.Ciclo);
    let result = this.expresion.ejecutar(env);
    do {
      for (const iterator of this.linstrucciones) {
        try {
          let r = iterator.ejecutar(newEnv);
          if (r != undefined) {
            if (r.type == Type.BREAK) {
              return; // aqui hago un return sin mas.
            } else if (r.type == Type.CONTINUE) {
              // continue; // aqui necesito llamar a continue
              break; // asi es como simulo el continue
            } else if (r.type == Type.NULL) {
              return undefined;
            } else {
              if (iterator instanceof Return) {
                return r;
              }
            }
          }
        } catch (err) {
          console.log(err);
        }
      }

      result = this.expresion.ejecutar(env);
    } while (result.value);
  }
}

module.exports.DoWhile = DoWhile;
