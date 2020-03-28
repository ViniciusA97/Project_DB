import 'package:flutter/material.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/client.dart';
import 'package:project_bd/Model/pratos.dart';

class Restaurant implements Client{

  int _numPedidos;
  int _id;
  String _name;
  String _password;
  String _urlImage;
  String _description;
  String _num;
  String _adress;
  String _email;
  DateTime _horaAbre;
  DateTime _horaFecha;
  double _nota;
  int _entrega = 0;
  List<Prato> _cardapio;
  List<Categories> _categories;


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

    if(obj['hora_abre'] != null)
      _horaAbre = DateTime.parse(obj['hora_abre']);
    if(obj['hora_fecha'] != null)
      _horaFecha = DateTime.parse(obj['hora_fecha']);

    _entrega = obj['entregaGratis'];
    _cardapio = new List<Prato>();
    // this._date = DateTime.parse(obj['date']);
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
    map['pratos'] = _cardapio;
    map['categorias'] = _categories;
    // map['hora_abre'] = _horaAbre;
    // map['hora_fecha'] = _horaFecha;
    map['entregaGratis'] = _entrega;
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
  int get entregaGratis => _entrega;
  DateTime get horaAbre => _horaAbre;
  DateTime get horaFecha => _horaFecha;
  List<Categories> get categories => _categories;

  String get tipoEntrega{
    if(_entrega == 1)
      return 'Entrega Grátis';
    else if(_entrega == 2)
      return 'Entrega Rápida';
    else 
      return 'escolha';
  }

  String gethorario(context) {
    if(horaAbre == null && horaFecha == null)
    { 
      return "defina - defina";
    }
    else if(horaAbre == null && horaFecha != null)
    {
      
      return "defina - ${TimeOfDay.fromDateTime(horaFecha).format(context)}";
    }
    else if(horaAbre != null && horaFecha == null)
    {
      return "${TimeOfDay.fromDateTime(horaAbre).format(context)} - defina";
    }
    else if(horaAbre != null && horaFecha != null)
    {
      return "${TimeOfDay.fromDateTime(horaAbre).format(context)} - ${TimeOfDay.fromDateTime(horaFecha).format(context)}";
    }
  }

  // String get entrega => _entregaGratis == 1 ? 'Entrega Grátis' : 'Entrega Rápida';

  void setCategories(List<Categories> cat) =>this._categories=cat;
  void setCardapio(List<Prato> list) => this._cardapio = list;
  void setEntrega(int entrega) => this._entrega = entrega;
  void setHoraAbre(DateTime horaAbre) => this._horaAbre = horaAbre;
  void setHoraFecha(DateTime horaFecha) => this._horaFecha = horaFecha;
  void addPrato(Prato prato) => this._cardapio.add(prato);

}