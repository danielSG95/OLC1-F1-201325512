const { Instruccion } = require("../abstract/Instruccion");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");
const { Error } = require("../analizador/Error");
class Declaracion extends Instruccion {
  constructor(name, type, expression, isConstant, line, column) {
    super(line, column);
    this.name = name;
    this.type = type;
    this.expression = expression;
    this.isConstant = isConstant;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    console.log("detectando una declaracion SIUUUUU");
    // console.log(this.expression);
    let isValid = true;

    let result = this.expression.ejecutar(env);
    if (result == undefined) {
      // lanazar un error
      this.#writeError("void", this.expression.name);
      return;
    }
    if (result.type == Type.ERR) {
      return;
    }

    if (this.type == Type.DECIMAL) {
      if (result.type != Type.NUMBER && result.type != Type.DECIMAL) {
        this.#writeError(this.name, result);
        isValid = false;
      }

      result.type = Type.DECIMAL;
    }

    if (this.type == Type.CHAR) {
      if (result.type != Type.NUMBER && result.type != Type.CHAR) {
        this.#writeError(this.name, result);
        isValid = false;
      }
      result.type = Type.CHAR; // esto podria quitarse
    }

    if (this.type != result.type) {
      this.#writeError(this.name, result);
      isValid = false;
    }

    if (isValid) {
      this.name.forEach((element) => {
        env.insertSymbol(element, result.value, result.type, this.isConstant);
      });
      // console.log(env.getEnv());
    } else {
      console.log("Se ha encontrado un error durante la declaracion.");
      throw new Error("no se puedo crear la variable");
    }
  }

  #writeError(result, lexema) {
    Singleton.getInstance().errores.push(
      new Error(
        lexema,
        this.line,
        this.column,
        `Error no se puede asignar el tipo ${result.type} a una variable de tipo ${this.type}`,
        "Error Semantico"
      )
    );
  }
}

module.exports.Declaracion = Declaracion;
