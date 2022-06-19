const { Instruccion } = require("../abstract/Instruccion");
const { Env, currentEnv } = require("../symbols/Env");
const { Type } = require("../symbols/Type");
const { Break } = require("./Break");
const { Continue } = require("./Continue");
const { Return } = require("./Return");
class While extends Instruccion {
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
    while (result.value) {
      for (const e of this.linstrucciones) {
        try {
          let r = e.ejecutar(newEnv);
          if (r != undefined) {
            if (r.type == Type.BREAK) {
              return; // aqui hago un return sin mas.
            } else if (r.type == Type.CONTINUE) {
              // continue; // aqui necesito llamar a continue
              break; // asi es como simulo el continue
            } else if (r.type == Type.NULL) {
              // aqui se que debo salir sin retornar nada.
              return undefined;
            } else {
              return r; // aqui estoy devolviendo un tipo de dato.
            }
          }
        } catch (err) {
          console.log(err);
        }
      }

      result = this.expresion.ejecutar(env);
    }
  }
}

module.exports.While = While;
