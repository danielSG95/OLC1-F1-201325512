const { Symbol } = require("../symbols/Symbol");
const sha256 = require("crypto-js").SHA256;
class Env {
  #tablaSimbolos;
  #tablaFunciones;
  constructor(anterior, typEnv) {
    this.anterior = anterior;
    this.#tablaSimbolos = new Map();
    this.#tablaFunciones = new Map();
    this.typEnv = typEnv;
    this.uid = this.generate_hash();
  }

  generate_hash() {
    var current_date = new Date().valueOf().toString();
    var random = Math.random().toString();
    return sha256(current_date + random);
  }

  getEnv() {
    return this.#tablaSimbolos;
  }

  getEnvFuncion() {
    return this.#tablaFunciones;
  }

  insertFuncion(nombre, valor) {
    // algo
    if (this.buscarFuncion(nombre) == null) {
      this.#tablaFunciones.set(nombre, valor);
      return true;
    }
    return false;
  }

  buscarFuncion(nombre) {
    for (const iterator of this.#tablaFunciones) {
      if (iterator[0] == nombre) {
        return iterator[1];
      }
    }

    return null;
  }

  insertSymbol(nombre, valor, type, isConstant) {
    if (this.buscarKey(nombre) == null) {
      // modificada
      this.#tablaSimbolos.set(
        nombre,
        new Symbol(valor, nombre, type, isConstant)
      );
    } else {
      // throw new TypeError("La variable ya existe en la tabla de simbolos.");
      console.log("la variable ya fue declarada en este entorno");
    }
  }

  buscarKey(nombre) {
    for (const iterator of this.#tablaSimbolos) {
      if (iterator[0] == nombre) {
        return iterator[1];
      }
    }
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

const currentEnv = {
  Ciclo: "ciclo",
  Funcion: "funcion",
  Bloque: "bloque",
  If: "if",
  Global: "global",
  For: "for",
  Switch: "switch",
};

module.exports.currentEnv = currentEnv;
module.exports.Env = Env;
