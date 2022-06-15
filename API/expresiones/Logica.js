const { Instruccion } = require('../abstract/Instruccion');

class Logica extends Instruccion {
    constructor(left, right, op, line, column) {
        this.left = left;
        this.right = right;
        this.op = op;
        this.line = line;
        this.column = column;

        super(line, column);
    }


    ejecutar(env) {

    }
}

const LogicaOp = {
    and: 1,
    or: 2,
    xor: 3,
    not: 4,
}

module.exports.LogicaOp = LogicaOp;
module.exports.Logica = Logica;