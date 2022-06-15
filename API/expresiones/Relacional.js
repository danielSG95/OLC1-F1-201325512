const { Instruccion } = require('../abstract/Instruccion');

class Relacional extends Instruccion {
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


const RelacionaOp = {
    mayor: 1,
    menor: 2,
    mayorI: 3,
    menorI: 4,
    igual: 5,
    dif: 6,
}

module.exports.Relacional = Relacional;
module.exports.RelacionaOp = RelacionaOp;