const { Type } = require('../symbols/Type');

class Literal {
    constructor(value, type, line, column) {
        this.value = value.toLowerCase();
        this.type = type;
        this.line = line;
        this.column = column;
    }

    ejecutar(env) {
        switch (this.type) {
            case Type.BOOLEAN:
                return {
                    value: (this.value == "true") ? Boolean(true) : Boolean(false),
                    type: Type.BOOLEAN,
                };
            case Type.CHAR:
                return {
                    value: this.value.charAt(0),
                    type: Type.CHAR,
                }
            case Type.NUMBER:
                return {
                    value: Number(this.value),
                    type: Type.NUMBER,
                }
            case Type.DECIMAL:
                return {
                    value: parseFloat(this.value),
                    type: Type.DECIMAL,
                }
            case Type.STRING:
                return {
                    value: this.value.toString(),
                    type: Type.STRING,
                }
            default:
                return {
                    value: this.value,
                    type: Type.Error,
                }
        }
    }
}


module.exports.Literal = Literal;