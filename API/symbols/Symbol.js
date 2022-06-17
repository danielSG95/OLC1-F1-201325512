class Symbol {
  constructor(value, id, Type, isConstant) {
    this.value = value;
    this.id = id;
    this.type = Type;
    this.isConstant = isConstant;
  }
}

exports.Symbol = Symbol;
