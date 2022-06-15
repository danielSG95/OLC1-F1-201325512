const Symbol = require('../symbols/Symbol');


class Env {
    #tablaSimbolos;
    constructor(anterior) {
        this.anterior = anterior;
        this.#tablaSimbolos = new Map();

    }

    getEnv() {
        return this.#tablaSimbolos;
    }

    insertSymbol(nombre, valor, type) {
        if (this.buscarKey(nombre) != null) {
            this.#tablaSimbolos.set(nombre, new Symbol(valor, nombre, type));
        } else {
            throw new TypeError('La variable ya existe en la tabla de simbolos.');
        }
    }

    buscarKey(nombre) {
        this.#tablaSimbolos.forEach((val, key) => {
            if (key == nombre) {
                return val;
            }
        })

        return null;
    }

    updateKey(nombre, valor) {
        this.#tablaSimbolos.forEach((val, key) => {
            if (key == nombre) {
                val = valor; // esto queda a prueba, no estoy seguro que funcione jeje salu2
            }
        })
    }
}


module.exports.Env = Env;