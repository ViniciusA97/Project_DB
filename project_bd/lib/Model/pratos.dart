import 'Preco.dart';

class Prato {
  int _idPrato;
  int _idRest;
  String _name;
  Preco _preco;
  String _descricao;
  String _img;
  int _active;

  Prato(this._idRest, this._name, this._preco, this._descricao, this._img);

  Prato.map(dynamic obj) {
    this._preco = Preco.map(obj);
    this._idPrato = obj['idPrato'];
    this._idRest = obj['idRest'];
    this._name = obj['name'];
    this._descricao = obj['descricao'];
    this._img = obj['img'];
    this._active = obj['active'];
  }

  Prato.mapRelatorio(dynamic obj) {
    this._preco = obj['media'] / obj['sumQnt'];
    this._idPrato = obj['idPrato'];
    this._idRest = obj['idRest'];
    this._name = obj['namePrato'];
    this._descricao = obj['descricaoPrato'];
    this._img = obj['imgPrato'];
    this._active = obj['active'];
  }

  Prato.mapJOIN(dynamic obj) {
    this._preco = Preco.map(obj);
    this._idPrato = obj['idPrato'];
    this._idRest = obj['idRest'];
    this._name = obj['namePrato'];
    this._descricao = obj['descricaoPrato'];
    this._img = obj['imgPrato'];
    this._active = obj['active'];
  }

  Map<String, dynamic> getMap() {
    Map<String, dynamic> temp;
    temp['idRest'] = _idRest;
    temp['name'] = _name;
    temp['preco'] = _preco;
    temp['descricao'] = _descricao;
    temp['img'] = _img;
    return temp;
  }

  int get idPrato => _idPrato;
  int get idRest => _idRest;
  String get name => _name;
  Preco get preco => _preco;
  String get descricao => _descricao;
  String get img => _img;
  int get active => this._active;

  void setPreco(Preco preco) {
    this._preco = preco;
  }

  void setDesc(String desc) {
    this._descricao = desc;
  }

  void setImg(String img) {
    this._img = img;
  }

  void setNome(String nome) {
    this._name = nome;
  }
}
