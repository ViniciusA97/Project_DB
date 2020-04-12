class Preco {
  DateTime _date;
  double _preco;
  int _idPreco;

  Preco(this._preco, this._date);

  Preco.map(dynamic obj) {
    this._idPreco = obj['idPreco'];
    this._preco = obj['preco'];
    try {
      this._date = DateTime.parse(obj['date']);
    } catch (err) {}
  }

  Preco.mapRelatorio(dynamic obj) {
    this._idPreco = obj['media'] / obj['sumQnt'];
    this._preco = obj['preco'];
    try {
      this._date = DateTime.parse(obj['date']);
    } catch (err) {}
  }

  void setId(int id) {
    this._idPreco = id;
  }

  DateTime get date => this._date;
  double get preco => this._preco;
  int get id => this._idPreco;
}
