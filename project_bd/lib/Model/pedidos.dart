
import 'pratos.dart';
import 'restaurant.dart';
import 'user.dart';

class Pedido{

  int _idPedido;
  User _user;
  Restaurant _rest;
  List<Prato> _prato = new List<Prato>();
  List<int> _qnt = new List<int>();
  DateTime _data;
  double _precoTotal;

  addPrato(Prato p){
    this._prato.add(p);
  }
  addQnt(int i){
    this._qnt.add(i);
  }

  Pedido(this._prato,this._user, this._qnt);

  Pedido.map(dynamic obj){
    _user = User.mapJOIN(obj);
    _rest = Restaurant.map(obj);
    _data = DateTime.parse(obj['data']);
    _idPedido = obj['idPedido'];
    _precoTotal = obj['preco'];
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map;
    map['user'] = this._user;
    map['rest'] = this._rest;
    map['prato'] = this._prato;
    map['data'] = this._data.toString();
    map['idPedido'] = this._idPedido;
    return map;
  }
  int get idPedido => this._idPedido;
  User get user => this._user;
  Restaurant get rest => this._rest;
  List<Prato> get prato => this._prato;
  DateTime get data=> this._data;
  double get preco => this._precoTotal;
  List<int> get qnt => this._qnt;

}