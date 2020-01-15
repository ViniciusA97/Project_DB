class Prato{

  int _idPrato;
  int _idRest;
  String _name;
  int _preco;
  String _descricao;

  Prato(this._idRest,this._name, this._preco, this._descricao);

  Prato.map(dynamic obj){
    this._idRest = obj['idRest'];
    this._name = obj['name'];
    this._preco = obj['preco'];
    this._descricao = obj['descricao'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> temp;
    temp['idRest']= _idRest;
    temp['name'] = _name;
    temp['preco'] = _preco;
    temp['descricao'] =_descricao;
    return temp;
  }
  int get id =>id;
  String get name =>_name;
  int get preco => _preco;
  String get descricao => _descricao;
}