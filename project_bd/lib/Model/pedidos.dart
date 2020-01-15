import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';

class Pedido{

  User _user;
  Restaurant _restaurant;
  Prato _prato;
  int _pedidoId;

  Pedido(this._user,this._restaurant, this._prato, this._pedidoId);

  Pedido.map(dynamic obj){
    _pedidoId = obj['pedidoId'];
    int userId = obj['userId'];
    int restaurantId = obj['restId'];
    int pratoId = obj['pratoId'];
    //query userId, restaurantId , pratoId ----- create the models
  }

  Map<String, dynamic> getMap(){
    Map<String, dynamic> map;
    map['userId'] = _user.id;
    map['pedidoId'] =_pedidoId;
    map['restId'] = _restaurant.id;
    map['pratoId'] = _prato.id;
    return map;
  }
  

}