const { Error } = require("../analizador/Error");

class Singleton {
  constructor() {
    this.console = "";
    this.errores = [];
    this.envReportNames = [];
  }

  static getInstance() {
    if (!this.instance) {
      this.instance = new Singleton();
    }

    return this.instance;
  }
}

module.exports.Singleton = Singleton;
