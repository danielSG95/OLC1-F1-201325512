const { Instruccion } = require('../abstract/Instruccion');

class Declaracion extends Instruccion {

    constructor(name, type, expression, isConstant, line, column) {
        super(line, column);
        this.name = name;
        this.type = type;
        this.expression = expression;
        this.constante = isConstant;
        this.line = line;
        this.column = column;

    }

    ejecutar(env) {
        console.log('detectando una declaracion SIUUUUU');
        let result = this.expression.ejecutar(env);

        if (result.type != this.type) {
            const error = `ERROR: No se puede asignar el tipo ${result.type} a una variable de tipo ${this.type}`;
            throw new TypeError(error);
        }
    }
}

module.exports.Declaracion = Declaracion;