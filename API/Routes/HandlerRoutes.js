
const { json } = require('body-parser');
const Router = require('express');
const router = Router.Router();

let parser = require('../analizador/Interprete');


router.post('/analizar', function (req, res, next) {
    let bufferOne = req.body;
    let data = bufferOne.toString('utf8');

    let out = parser.analizar(data);
    // console.log(out.tokens);
    
    res.send(JSON.stringify(out));
    
    /*
    if (out === true) {
        res.send({ status: 200, msg: 'ok', ltk: json(out.tokens) });
    } else {
        res.send({ status: 500, msg: 'error', ltk: json(out.tokens) });
    }*/


})



module.exports.router = router;
