
import 'pratos.dart';
import 'restaurant.dart';
import 'user.dart';

class Pedido{

  User _user;
  Restaurant _rest;
  Prato _prato;
  DateTime _data;


  Pedido(this._prato,this._rest,this._user, this._data);

  Pedido.map(dynamic obj){
    _user = obj['user'];
    _rest = obj['rest'];
    _prato = obj['prato'];
    _data = obj['data'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map;
    map['user'] = this._user;
    map['rest'] = this._rest;
    map['prato'] = this._prato;
    map['data'] = this._data.toString();
    return map;
  }

  User get user => this._user;
  Restaurant get rest => this._rest;
  Prato get prato => this._prato;
  DateTime get data=> this.data;

}