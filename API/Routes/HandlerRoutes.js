const Router = require("express");
const router = Router.Router();
const path = require("path");
const { Grafo } = require("../ast/Grafo");
let parser = require("../analizador/Interprete").analizar;
const parser2 = require("../analizador/AstGenerator");

let out = null;

const response = {
  status: 200,
  message: "",
  payload: undefined,
};

router.post("/analizar", async function (req, res, next) {
  let bufferOne = req.body;
  let data = bufferOne.toString("utf8");

  out = await parser(data);

  if (!out.foundFatalErrors) {
    response.message = "ok";
    response.payload = out.res.consola;
    response.status = 200;
  } else {
    response.message = "error";
    response.status = 501;
    response.payload = out.res.errores;
  }

  res.send(JSON.stringify(response));
});

router.post("/getAst", async function (req, res, next) {
  try {
    // aqui se deberia de llamar a la funcion que genera el diagrama de ast.
    let bufferOne = req.body;
    let data = bufferOne.toString("utf8");
    let raiz = parser2.parse(data);
    let miGrafo = new Grafo(raiz);
    await miGrafo.graficar();
    res.sendFile(path.resolve("Recursos/arbol.png"));
  } catch (error) {
    console.error(error);
    return res.send({ status: 501, msg: "error al obtener el ast solicitado" });
  }

  next();
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
