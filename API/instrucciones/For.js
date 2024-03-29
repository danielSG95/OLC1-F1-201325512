const { Instruccion } = require("../abstract/Instruccion");
const { Env, currentEnv } = require("../symbols/Env");
const { Type } = require("../symbols/Type");
const { Return } = require("./Return");

class For extends Instruccion {
  constructor(
    declaracion,
    condicion,
    incremento,
    linstrucciones,
    line,
    column
  ) {
    super(line, column);
    this.declaracion = declaracion;
    this.condicion = condicion;
    this.incremento = incremento;
    this.linstrucciones = linstrucciones;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    // algo
    let forEnv = new Env(env, currentEnv.For);

    // primero deberia de registrar la declaracion del for.
    this.declaracion.ejecutar(forEnv);
    // this.incremento.ejecutar(forEnv);
    let result = this.condicion.ejecutar(forEnv);

    while (result.value) {
      for (const iterator of this.linstrucciones) {
        let r = iterator.ejecutar(forEnv);
        if (r != undefined) {
          if (r.type == Type.Break) {
            return;
          } else if (r.type == Type.CONTINUE) {
            // continue;
            break; // esto simulara un continue???
          } else if (r.type == Type.NULL) {
            return undefined;
          } else {
            // aqui esto tiene que dar un error con instrucciones que puedan ser manejadas como expresiones.
            if (iterator instanceof Return) {
              return r;
            }
          }
        }
      }
      this.incremento.ejecutar(forEnv);
      result = this.condicion.ejecutar(forEnv);
    }
  }
}

module.exports.For = For;
