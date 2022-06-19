const { json } = require("body-parser");
const { response } = require("express");
const Router = require("express");
const router = Router.Router();

let parser = require("../analizador/Interprete");
let out = null;

router.post("/analizar", function (req, res, next) {
  let bufferOne = req.body;
  let data = bufferOne.toString("utf8");

  out = parser.analizar(data);
  // console.log(out.tokens);

  res.send(JSON.stringify(out));

  /*
    if (out === true) {
        res.send({ status: 200, msg: 'ok', ltk: json(out.tokens) });
    } else {
        res.send({ status: 500, msg: 'error', ltk: json(out.tokens) });
    }*/
});

router.get("/getErrores", function (re, res, next) {
  let response = {
    res: "no errors found",
    status: 404,
  };
  if (out != null) {
    response = {
      res: out.errores,
      status: 200,
    };
  }

  res.send(JSON.stringify(response));
});

module.exports.router = router;
