const { Type } = require('../symbols/Type');
const { Expresion } = require('../abstract/expresion');

class Aritmetica extends Expresion {
    constructor(left, right, type, line, column) {
        super(line, column)
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
        }

        const leftOp = this.left.ejecutar();
        const rightOp = this.right.ejecutar();

        switch (this.type) {
            case AritmeticOp.MAS:

                if (leftOp.type == Type.BOOLEAN || rightOp.type == Type.BOOLEAN) {
                    throw new TypeError(`Tipos incompatibles {Type.BOOLEAN} no se puede operar con {Type.NUMBER}`);
                }
                result = {
                    value: (leftOp.value + rightOp.value),
                    type: getType(leftOp, rightOp)

                }
                break;
            case AritmeticOp.MENOS:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con la operacion resta');
                }

                result = {
                    value: (leftOp.value - rightOp.value),
                    type: getType(leftOp, rightOp),
                };

                break;

            case AritmeticOp.MULT:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con la operacion multiplicacion');
                }

                result = {
                    value: (leftOp.value * rightOp.value),
                    type: getType(leftOp, rightOp),
                };
                break;
            case AritmeticOp.DIV:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con la operacion division');
                }

                result = {
                    value: (leftOp.value / rightOp.value),
                    type: getType(leftOp, rightOp),
                };
                break;
            case AritmeticOp.POW:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con la Potencia');
                }

                result = {
                    value: (Math.pow(leftOp.value, rightOp.value)),
                    type: getType(leftOp, rightOp),
                };
                break;
            case AritmeticOp.MOD:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con operacion Modulo');
                }

                result = {
                    value: (leftOp.value % rightOp.value),
                    type: getType(leftOp, rightOp),
                };
                break;
            case AritmeticOp.UMENOS:
                if (!validarOp(leftOp, rightOp)) {
                    throw new TypeError('Tipos incompatibles con la operacion');
                };

                result = {
                    value: (-1 * leftOp.value),
                    type: getType(leftOp, rightOp),
                };
                break;
        }
        return result;
    }
}

function validarOp(op1, op2) {
    /**
     * La resta unicamente se puede ejecutar conlos siguientes tipos: int, char, double
     */
    let salida = false;
    if (op1.type == Type.STRING || op2.type == Type.STRING) {
        salida = false;
    }

    if (op1.type == Type.BOOLEAN || op2.type == Type.BOOLEAN) {
        salida = fasle;
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
}


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