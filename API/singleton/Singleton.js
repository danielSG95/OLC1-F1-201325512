class Singleton {
  constructor() {
    this.console = "";
    this.errores = [];
  }

  static getInstance() {
    if (!this.instance) {
      this.instance = new Singleton();
    }

    return this.instance;
  }
}

module.exports.Singleton = Singleton;
