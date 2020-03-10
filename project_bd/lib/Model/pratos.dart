import 'Preco.dart';

class Prato{

  int _idPrato;
  int _idRest;
  String _name;
  Preco _preco;
  String _descricao;
  String _img;

  Prato(this._idRest,this._name, this._preco, this._descricao, this._img);

  Prato.map(dynamic obj){
    this._idPrato = obj['idPrato'];
    this._idRest = obj['idRest'];
    this._name = obj['name'];
    this._preco = obj['preco'];
    this._descricao = obj['descricao'];
    this._img = obj['img'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> temp;
    temp['idRest']= _idRest;
    temp['name'] = _name;
    temp['preco'] = _preco;
    temp['descricao'] =_descricao;
    temp['img'] = _img;
    return temp;
  }

  int get idPrato => _idPrato;
  int get idRest => _idRest;
  String get name =>_name;
  Preco get preco => _preco;
  String get descricao => _descricao;
  String get img => _img; 

  void setPreco(Preco preco){
    this._preco = preco;
  }
}