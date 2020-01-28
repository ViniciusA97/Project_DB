import 'package:project_bd/Model/client.dart';
import 'package:project_bd/Model/pratos.dart';

class Restaurant implements Client{

  String _name;
  String _password;
  int _numPedidos;
  List<Prato> _cardapio;
  int _id;
  String _urlImage;
  String _description;
  String _num;
  String _adress;
  String _email;

  Restaurant(this._name,this._password, this._cardapio, this._numPedidos, this._urlImage,
              this._description,this._num, this._email,this._adress);

  Restaurant.map(dynamic obj){
    _name = obj['name'];
    _password = obj['password'];
    _numPedidos = obj['numPedidos'];
    _id =obj ['idRest'];
    _urlImage = obj['image'];
    _description = obj['description'];
    _num = obj['num'];
    _adress= obj['address'];
    _email = obj['email'];
  }

  Map<String, dynamic> map(){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['name'] = _name;
    map['password'] = _password;
    map['numPedidos'] = _numPedidos;
    map['cardapio'] = _cardapio; 
    map['image'] = _urlImage;
    map['description'] = _description;
    map['num'] =_num;
    map['email']= _email;
    map['address']= _adress;
    return map;
  }
  

  int get id =>_id;
  String get url => _urlImage;
  String get name => _name;
  String get password => _password;
  int get numPedidos => _numPedidos;
  List<Prato> get cardapio => _cardapio; 
  String get descriprion => _description;
  String get nume =>_num;
  String get email =>_email;
  String get address =>_adress;

}