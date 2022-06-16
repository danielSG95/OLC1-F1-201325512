const { Type } = require("../symbols/Type");
const Error = require("../analizador/Error").Error;
const { Singleton } = require("../singleton/Singleton");
class Literal {
  constructor(value, type, line, column) {
    this.value = value.toLowerCase();
    this.type = type;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    switch (this.type) {
      case Type.BOOLEAN:
        return {
          value: this.value == "true" ? Boolean(true) : Boolean(false),
          type: Type.BOOLEAN,
        };
      case Type.CHAR: // esto es un caso especial
        return {
          value: this.value.charAt(0),
          type: Type.CHAR,
        };
      case Type.NUMBER:
        return {
          value: Number(this.value),
          type: Type.NUMBER,
        };
      case Type.STRING:
        const value = this.value.toString().replaceAll('"', "");
        return {
          value: value,
          type: Type.STRING,
        };
      case Type.IDENTIFICADOR:
        let varValue = env.buscarVariable(this.value);
        let val, t;
        if (varValue == null) {
          val = null;
          t = Type.ERR;
          Singleton.getInstance().errores.push(
            new Error(
              this.value,
              this.line,
              this.column,
              `La variable '${this.value}' NO ha sido declarada`,
              "Error Semantico"
            )
          );
        } else {
          val = varValue.value;
          t = varValue.type;
        }

        return {
          value: val,
          type: t,
        };
      default:
        return {
          value: this.value,
          type: Type.Error,
        };
    }
  }

  #varlidarChar(value) {
    value = value.toString();
    let salida = -1;
    if (value.length > 1) {
      switch (value) {
        case "\n":
          salida = 10;
          break;
        case "\r":
          salida = 13;
          break;
        // prettier-ignore
        case '\"':
          salida = 34;
          break;
        case "\\":
          salida = 92;
          break;
        case "\t":
          salida = 9;
          break;
      }
    } else {
      salida = value.charAt(0);
    }

    return salida;
  }
}

module.exports.Literal = Literal;
