const parser = require('./analizador');
const { Env } = require('../symbols/Env');
function analizar(text) {
    try {
        let result = parser.parse(text);

        const global = new Env(null);
        result.ast.forEach(element => {
            try {
                element.ejecutar(global);
                console.log(element);
            } catch (err) {
                console.error(err);
            }
        });


        return true;
    } catch (err) {
        console.error(err);
        return false;
    }
}




module.exports.analizar = analizar;