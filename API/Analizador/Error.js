
class Error {
    constructor(lexema, linea, columna, descripcion, tipo) {
        this.lexema = lexema;
        this.linea = linea;
        this.columna = columna;
        this.descripcion = descripcion;
        this.tipo = tipo;
    }
}


module.exports.Error = Error;