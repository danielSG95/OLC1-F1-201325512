const { Type } = require("../symbols/Type");
const { Expresion } = require("../abstract/expresion");
const { Singleton } = require("../singleton/Singleton");
const { Error } = require("../analizador/Error");
class Aritmetica extends Expresion {
  constructor(left, right, type, line, column) {
    super(line, column);
    this.left = left;
    this.right = right;
    this.type = type;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    let result = {
      value: null,
      type: Type.ERR,
    };

    const leftOp = this.left.ejecutar(env);
    const rightOp = this.right.ejecutar(env);

    switch (this.type) {
      case AritmeticOp.MAS:
        if (leftOp.type == Type.BOOLEAN || rightOp.type == Type.BOOLEAN) {
          if (leftOp.type == Type.STRING || rightOp.type == Type.STRING) {
          } else {
            this.writeError(
              `Tipos incompatibles. La operacion 'suma' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
            );
          }
        }
        result = {
          value: leftOp.value + rightOp.value,
          type: getType(leftOp, rightOp),
        };
        break;
      case AritmeticOp.MENOS:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'resta' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        result = {
          value: leftOp.value - rightOp.value,
          type: getType(leftOp, rightOp),
        };

        break;

      case AritmeticOp.MULT:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'division' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        result = {
          value: leftOp.value * rightOp.value,
          type: getType(leftOp, rightOp),
        };
        break;
      case AritmeticOp.DIV:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'division' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        let resultado = leftOp.value / rightOp.value;
        let flag = Type.NUMBER;
        if (this.#isDecimal(resultado)) {
          resultado = resultado.toFixed(2);
          flag = Type.DECIMAL;
        }
        result = {
          value: resultado,
          type: flag,
        };
        break;
      case AritmeticOp.POW:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'potencia' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        result = {
          value: Math.pow(leftOp.value, rightOp.value),
          type: getType(leftOp, rightOp),
        };
        break;
      case AritmeticOp.MOD:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'modulo' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        result = {
          value: leftOp.value % rightOp.value,
          type: getType(leftOp, rightOp),
        };
        break;
      case AritmeticOp.UMENOS:
        if (!validarOp(leftOp, rightOp)) {
          this.writeError(
            `Tipos incompatibles. La operacion 'negacion' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`
          );
        }

        result = {
          value: -1 * leftOp.value,
          type: getType(leftOp, rightOp),
        };
        break;
    }
    return result;
  }

  writeError(msg) {
    Singleton.getInstance().errores.push(
      new Error(
        "Operacion Aritmetica",
        this.line,
        this.column,
        msg,
        "Error Semantico"
      )
    );
  }

  #isDecimal(resultado) {
    resultado = resultado.toString();
    if (resultado.includes(".")) {
      return true;
    }

    return false;
  }
}

function validarOp(op1, op2) {
  /**
   * La resta unicamente se puede ejecutar con los siguientes tipos: int, char, double
   */
  let salida = true;
  if (op1.type == Type.STRING || op2.type == Type.STRING) {
    salida = false;
  }

  if (op1.type == Type.BOOLEAN || op2.type == Type.BOOLEAN) {
    salida = false;
  }

  return salida;
}

const getType = (op1, op2) => {
  if (op1.type == Type.STRING || op2.type == Type.STRING) {
    return Type.STRING;
  }

  if (op1.type == Type.DECIMAL || op2.type == Type.DECIMAL) {
    return Type.DECIMAL;
  }

  return Type.NUMBER;
};

const AritmeticOp = {
  MAS: 1,
  MENOS: 2,
  MULT: 3,
  DIV: 4,
  POW: 5,
  UMENOS: 6,
  MOD: 7,
};

module.exports.Aritmetica = Aritmetica;
module.exports.AritmeticOp = AritmeticOp;
