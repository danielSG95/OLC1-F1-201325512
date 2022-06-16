const { Instruccion } = require("../abstract/Instruccion");
const { Error } = require("../analizador/Error");
const { Singleton } = require("../singleton/Singleton");
const { Type } = require("../symbols/Type");

class Logica extends Instruccion {
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
    let leftOp = this.left.ejecutar(env);
    let rightOp = this.right.ejecutar(env);

    if (leftOp.type != Type.BOOLEAN || rightOp.type != Type.BOOLEAN) {
      this.#writeError(leftOp, rightOp, this.op);
      return result;
    }

    switch (this.op) {
      case LogicaOp.and:
        result = { value: leftOp.value && rightOp.value, type: Type.BOOLEAN };
        break;
      case LogicaOp.not:
        result = { value: !rightOp.value, type: Type.BOOLEAN };
        break;
      case LogicaOp.or:
        result = { value: leftOp.value || rightOp.value, type: Type.BOOLEAN };
        break;
      case LogicaOp.xor:
        result = { value: leftOp.value ^ rightOp.value, type: Type.BOOLEAN };
        break;
    }

    return result;
  }

  #writeError(leftOp, rightOp, top) {
    Singleton.getInstance().errores.push(
      new Error(
        "",
        this.line,
        this.column,
        `El operador '${top}' no se puede operar con los tipos ${leftOp.type}, ${rightOp.type}`,
        "Error Semantico"
      )
    );
  }
}

const LogicaOp = {
  and: "&&",
  or: "||",
  xor: "^",
  not: "!",
};

module.exports.LogicaOp = LogicaOp;
module.exports.Logica = Logica;
