
class Expresion {
    constructor(line, column) {
        this.line = line;
        this.column = column + 1;

        if (new.target === Expresion) {
            throw new TypeError('Abstract class');
        }

    }


    ejecutar(env) {
        throw new Error('You have to implement the method "ejecutar"');
    }
}

module.exports.Expresion = Expresion