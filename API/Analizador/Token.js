

class Token {
    constructor(token, lexema, linea, columna) {
        this.token = token;
        this.lexema = lexema;
        this.linea = linea;
        this.columna = columna;
    }
}

module.exports.Token = Token