
import 'pratos.dart';
import 'restaurant.dart';
import 'user.dart';

class Pedido{

  int _idPedido;
  User _user;
  Restaurant _rest;
  List<Prato> _pratos;
  DateTime _data;
  double _precoTotal;


  Pedido(this._pratos, this._rest, this._user, this._data, this._idPedido);

  Pedido.map(dynamic obj){
    _user = obj['user'];
    _rest = obj['rest'];
    _pratos = obj['prato'];
    _data = obj['data'];
    _idPedido = obj['idPedido'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map;
    map['user'] = this._user;
    map['rest'] = this._rest;
    map['prato'] = this._pratos;
    map['data'] = this._data.toString();
    map['idPedido'] = this._idPedido;
    return map;
  }
  int get idPedido => this._idPedido;
  User get user => this._user;
  Restaurant get rest => this._rest;
  List<Prato> get prato => this._pratos;
  DateTime get data=> this._data;
  double get preco => this._precoTotal;

}