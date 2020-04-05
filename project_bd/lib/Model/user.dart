import 'package:project_bd/Model/client.dart';

class User implements Client{

  int _id;
  String _name;
  String _password;
  String _email;
  String _address;
  String _celNumber;

  User(this._name, this._password,this._email, this._address, this._celNumber);
  
  User.map(dynamic obj) {
    this._id = obj['idUser'];
    this._name = obj['name'];
    this._password = obj['password'];
    this._email = obj['email'];
    this._address = obj['address'];
    this._celNumber = obj['celNumber'];
  }

  User.mapJOIN(dynamic obj){
    this._id = obj['idUser'];
    this._name = obj['nameUser'];
    this._email = obj['emailUser'];
    this._address = obj['addressUser'];
    this._celNumber = obj['numerUser'];
  }

  int get id=> _id;
  String get name => _name;
  String get password => _password;
  String get email => _email;
  String get address => _address;
  String get celNumber => _celNumber;

  void setAdress(String adress) => this._address = adress;
  
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map["name"] = _name;
    map["password"] = _password;
    map['email'] = _email;
    map['address'] = _address;
    map['celNumber'] = _celNumber;
    return map;
  }


}