const { Instruccion } = require("../abstract/Instruccion");
const { Error } = require("../analizador/Error");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");

class Relacional extends Instruccion {
  constructor(left, right, op, line, column) {
    super(line, column);
    this.left = left;
    this.right = right;
    this.op = op;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    let result = {
      value: null,
      type: Type.ERR,
    };

    let izdo = this.left.ejecutar(env);
    let dcho = this.right.ejecutar(env);

    console.log(typeof izdo);

    switch (this.op) {
      case RelacionaOp.mayor:
        if (!this.#valuarRelacional(izdo, dcho)) {
          // write error;
          this.#writeError(izdo, dcho, RelacionaOp.mayor);
        }

        result = {
          value: izdo.value > dcho.value,
          type: Type.BOOLEAN,
        };

        break;
      case RelacionaOp.menor:
        if (!this.#valuarRelacional(izdo, dcho)) {
          // write error;

          this.#writeError(izdo, dcho, RelacionaOp.menor);
        }

        result = { value: izdo.value < dcho.value, type: Type.BOOLEAN };
        break;
      case RelacionaOp.mayorI:
        if (!this.#valuarRelacional(izdo, dcho)) {
          // write error;

          this.#writeError(izdo, dcho, RelacionaOp.mayorI);
        }
        result = { value: izdo.value >= dcho.value, type: Type.BOOLEAN };
        break;
      case RelacionaOp.menorI:
        if (!this.#valuarRelacional(izdo, dcho)) {
          // write error;
          this.#writeError(izdo, dcho, RelacionaOp.menorI);
        }
        result = { value: izdo.value <= dcho.value, type: Type.BOOLEAN };
        break;
      case RelacionaOp.igual:
        if (!this.#validarIgualdad(izdo, dcho)) {
          // write error;
          this.#writeError(izdo, dcho, RelacionaOp.igual);
        }

        result = { value: izdo.value == dcho.value, type: Type.BOOLEAN };
        break;
      case RelacionaOp.dif:
        if (!this.#validarIgualdad(izdo, dcho)) {
          // write error;
          this.#writeError(izdo, dcho, RelacionaOp.dif);
        }

        result = { value: izdo.value != dcho.value, type: Type.BOOLEAN };
        break;
    }
    return result;
  }

  #valuarRelacional(op1, op2) {
    let salida = true;
    if (op1.type == Type.STRING || op2.type == Type.STRING) {
      salida = false;
    }

    if (op1.type == Type.BOOLEAN || op2.type == Type.BOOLEAN) {
      salida = false;
    }

    if (op1.type == Type.IDENTIFICADOR || op2.type == Type.IDENTIFICADOR) {
      salida = false;
    }

    if (op1.type == Type.ERR || op2.type == Type.ERR) {
      salida = false;
    }

    return salida;
  }

  #writeError(op1, op2, top) {
    Singleton.getInstance().errores.push(
      new Error(
        "",
        this.line,
        this.column,
        `Los operandos '${op1.value}', '${op2.value}' no se pueden operar con: '${top}'`,
        "Error Semantico"
      )
    );
  }

  #validarIgualdad(op1, op2) {
    let salida = true;
    if (op1.type == Type.ERR || op2.type == Type.ERR) {
      salida = false;
    }

    return salida;
  }
}

const RelacionaOp = {
  mayor: ">",
  menor: "<",
  mayorI: ">=",
  menorI: "<=",
  igual: "==",
  dif: "!=",
};

module.exports.Relacional = Relacional;
module.exports.RelacionaOp = RelacionaOp;
