import 'package:project_bd/Model/client.dart';
import 'package:project_bd/Model/pratos.dart';

class Restaurant implements Client{

  String _name;
  int _password;
  int _numPedidos;
  List<Prato> _cardapio;
  int _id;
  String _urlImage;

  Restaurant(this._name,this._password, this._cardapio, this._numPedidos, this._urlImage);

  Restaurant.map(dynamic obj){
    _name = obj['name'];
    _password = obj['password'];
    _numPedidos = obj['numPedidos'];
    _id =obj ['idRest'];
    _urlImage = obj['image'];
  }

  Map<String, dynamic> map(){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['name'] = _name;
    map['password'] = _password;
    map['numPedidos'] = _numPedidos;
    map['cardapio'] = _cardapio; 
    map['image'] = _urlImage;
    return map;
  }
  

  int get id =>_id;
  String get url => _urlImage;
  String get name => _name;
  int get password => _password;
  int get numPedidos => _numPedidos;
  List<Prato> get cardapio => _cardapio; 
}