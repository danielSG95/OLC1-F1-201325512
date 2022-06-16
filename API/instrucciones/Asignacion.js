const { Instruccion } = require("../abstract/Instruccion");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");

class Asignacion extends Instruccion {
  constructor(name, expresion, line, column) {
    super(line, column);
    this.name = name;
    this.expresion = expresion;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    /**
     * 1- Se debe validar que exista la variable en mi tabla de simbolos.
     * 2- Validar que el tipo de retorno de la expresion, sea igual que el tipo de la variable ( A exception del double.)
     * 3- Solo ?
     */

    let symbol = env.buscarVariable(this.name);
    if (symbol != null) {
      // resolver la expresion
      // ahora los casos especiales
      let result = this.expresion.ejecutar(env);
      let isValid = true;

      if (symbol.type == Type.DECIMAL) {
        if (result.type != Type.NUMBER && result.type != Type.DECIMAL) {
          this.#writeError(this.name, result);
          isValid = false;
        }

        result.type = Type.DECIMAL;
      }

      if (symbol.type == Type.CHAR) {
        if (result.type != Type.NUMBER && result.type != Type.CHAR) {
          this.#writeError(this.name, result);
          isValid = false;
        }
        result.type = Type.CHAR; // esto podria quitarse
      }

      if (symbol.type != result.type) {
        this.#writeError(this.name, result);
        isValid = false;
      }

      if (isValid) {
        // ahora aqui deberia de llamar al que hace la actualizacion.
        symbol.value = result.value;
        env.updateVar(this.name, symbol);
        console.log(env.getEnv());
      } else {
        console.log("Se ha encontrado un error durante la declaracion.");
      }
    } else {
      // se debe de gerar un nuevo error.
      Singleton.getInstance().errores.push(
        this.name,
        this.line,
        this.column,
        `La variable no ha sido declarada`,
        "Error Semantico"
      );
    }
  }

  #writeError(result, lexema) {
    Singleton.getInstance().errores.push(
      new Error(
        lexema,
        this.line,
        this.column,
        `Error no se puede asignar el tipo ${result.type} a una variable de tipo ${symbol.type}`,
        "Error Semantico"
      )
    );
  }
}

module.exports.Asignacion = Asignacion;
