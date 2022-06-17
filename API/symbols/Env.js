const { Symbol } = require("../symbols/Symbol");

class Env {
  #tablaSimbolos;
  constructor(anterior) {
    this.anterior = anterior;
    this.#tablaSimbolos = new Map();
  }

  getEnv() {
    return this.#tablaSimbolos;
  }

  insertSymbol(nombre, valor, type, isConstant) {
    if (this.buscarKey(nombre) == null) {
      // modificada
      this.#tablaSimbolos.set(
        nombre,
        new Symbol(valor, nombre, type, isConstant)
      );
    } else {
      throw new TypeError("La variable ya existe en la tabla de simbolos.");
    }
  }

  // esto queda temporalmente sin uso.
  buscarKey(nombre) {
    this.#tablaSimbolos.forEach((val, key) => {
      if (key == nombre) {
        return val;
      }
    });

    return null;
  }

  buscarVariable(nombre) {
    return this.#findVariable(nombre, this);
  }

  #findVariable(nombre, padre) {
    if (padre == null || padre == undefined) {
      return null;
    }

    let current = padre.#tablaSimbolos;
    for (const element of current) {
      if (element[0] == nombre) {
        return element[1];
      }
    }

    return this.#findVariable(nombre, padre.anterior);
  }

  updateVar(nombre, newSymbol) {
    return this.#updateSymbol(nombre, newSymbol, this);
  }

  #updateSymbol(nombre, newSymbol, padre) {
    if (padre == null || padre == undefined) {
      return false;
    }

    let current = padre.#tablaSimbolos;
    for (const element of current) {
      if (element[0] == nombre) {
        if (element[1].isConstant) {
          console.log("no se puede modificar una constante");
          return false;
        }
        current.set(element[0], newSymbol);
        return true;
      }
    }

    return this.#updateSymbol(nombre, newSymbol, padre.anterior);
  }
}

module.exports.Env = Env;
