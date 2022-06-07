const parser = require('./analizador');

function analizar(text) {
    try {
        parser.parse(text);
        return true;
    } catch (err) {
        console.error(err);
        return false;
    }
}




module.exports.analizar = analizar;