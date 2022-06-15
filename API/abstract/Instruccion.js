
class Instruccion {
    constructor(line, column) {
        this.line = line;
        this.column = column;


        // Se esta simulando una clase abstracta. Si se encuentra alguna instancia de la misma, se lanza un error.
        if (new.target === Instruccion) {
            throw new TypeError('Cannot construct Abstract instances directly');
        }

    }


    ejecutar(env) {
        throw new Error('You have to implement the method "ejecutar"');
    }
}


module.exports.Instruccion = Instruccion;