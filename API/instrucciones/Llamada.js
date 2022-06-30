const { Instruccion } = require("../abstract/Instruccion");
const { Error } = require("../analizador/Error");
const { Singleton } = require("../singleton/Singleton");
const { Env, currentEnv } = require("../symbols/Env");
const { Type } = require("../symbols/Type");
const { Declaracion } = require("./Declaracion");
const { Return } = require("./Return");

class Llamada extends Instruccion {
  constructor(name, lArgs, line, column) {
    super(line, column);
    this.name = name;
    this.lArgs = lArgs;
    this.line = line;
    this.column = column;
  }

  ejecutar(env) {
    // Aqui se debe implementar las llamadas.

    let myFunc = env.buscarFuncion(this.name);
    let newEnv = new Env(env, currentEnv.Funcion);
    if (myFunc != null) {
      // ejecutar aqui lo necesario para la funcion.
      /**
       * una vez se recupera la funcion, hay algunas cosas que hacer antes de ejcutar.
       * 1- se deben declarar todas las variables en un nuevo Env
       * 2- validar que la lista de Argumentos sea igual que las variables declaradas.
       * 3- retornar el resultado.
       */
      try {
        if (this.lArgs != undefined && myFunc.lArgs != undefined) {
          if (this.lArgs.length != myFunc.lArgs.length) {
            this.#writeError(
              `La cantidad de argumentos dados a la funcion no coincide con ninguna funcion creada`
            );
            return undefined;
          }
          for (let i = 0; i < myFunc.lArgs.length; i++) {
            let tempo = this.lArgs[i].ejecutar(newEnv);
            if (tempo.type != myFunc.lArgs[i].type) {
              this.#writeError(
                "Los tipos de los argumentos dados, no coinciden con ninguna funcion declarada"
              );
              return undefined;
            }
          }
          for (let i = 0; i < myFunc.lArgs.length; i++) {
            let tempDec = new Declaracion(
              [myFunc.lArgs[i].value],
              myFunc.lArgs[i].type,
              this.lArgs[i],
              false,
              this.line,
              this.column
            );

            tempDec.ejecutar(newEnv);
            // aqui deberia de ejecutar
          }
        }

        for (const iterator of myFunc.lInstrucciones) {
          // ejecutar las instrucciones correspondientes.
          let r = iterator.ejecutar(newEnv);
          if (r != undefined) {
            if (myFunc.type != Type.VOID) {
              // aqui se que estoy esperando algun tipo de retorno.
              if (iterator instanceof Return) {
                if (myFunc.type == r.type) {
                  return r;
                } else {
                  // error porque el tipo de retorno no coincide con el definido en la funcion
                  this.#writeError(
                    "El tipo de retorno no coincide con el definido en la funcion"
                  );
                  return undefined;
                }
              }
            } else {
              if (iterator instanceof Return) {
                if (r.type == Type.NULL) {
                  // aqui se que debo escapar, pues encontre un return;
                  return undefined; // esto aun hay que probarlo
                }
                this.#writeError(
                  "No se puede retornar una expresion en una funcion de tipo void"
                );
                return undefined;
              }
            }
          }
        }
      } catch (error) {
        console.log(error);
      }
    } else {
      this.#writeError(
        "La funcion a la que hace referencia no se encuentra en la tabla de simbolos"
      );
    }
  }

  #writeError(desc) {
    Singleton.getInstance().errores.push(
      new Error(this.name, this.line, this.column, desc, "Error Semantico")
    );

    // throw new TypeError(desc);
  }
}

module.exports.Llamada = Llamada;
