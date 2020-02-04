
class Pedido{

  int _userId;
  int _restId;
  int _pratoId;
  DateTime _data;

  Pedido(this._pratoId,this._restId,this._userId, this._data);

  Pedido.map(dynamic obj){
    _userId = obj['userId'];
    _restId = obj['restId'];
    _pratoId = obj['pratoId'];
    _data = obj['data'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map;
    map['userId'] = this._userId;
    map['restId'] = this._restId;
    map['pratoId'] = this._pratoId;
    map['data'] = this._data.toString();
    return map;
  }

  int get idUser => this._userId;
  int get idRest => this._restId;
  int get idPrato => this._pratoId;
  DateTime get data=> this.data;

}