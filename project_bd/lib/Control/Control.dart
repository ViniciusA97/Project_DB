import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/Model/itemCart.dart';
import 'package:project_bd/pages/HomeUserPage/CartPage.dart';

class Control{

  final DatabaseHelper _db = DatabaseHelper.internal();

  static Control _instance;

  factory Control() {
    _instance ??= Control._internal();
    return _instance;
  }
  Control._internal();

  List<Prato> _pratos = new List<Prato>();
  List<int> _qnt = new List<int>();
  int isGratis;
  User user;
  
  //faz login do usuario
  Future<User> doLogin(String email, String password) async{
    return await this._db.getUser(email, password);
  }

  //faz o login do restaurant
  Future<Restaurant> doLoginRestaurant(String name, String password) async{
    return await this._db.getRestLogin(name, password);
  }

  //Salva o usuario, retorna false se houver erro no salvamento
  Future<bool> saveUser(User u) async{
      return await this._db.saveUser(u);
  }

  //Salva o restaurante, se houver erro no salvamento
  Future<bool> saveRest( Restaurant rest) async{
    return await this._db.saveRest(rest);
  }

  //salva um prato
  Future<bool> savePrato(Prato prato) async{
    return await this._db.savePrato(prato);
  }

  Future<bool> updatePreco(double preco, int id) async{
    return await this._db.updatePrecoPrato(preco,id);
  }

  Future<Restaurant> getRestByIdRest(int id)async{
    return await this._db.getRestById(id);
  }

  ///Pega todas as categorias
  Future<List<Categories>> getAllCategories() async{
    return await this._db.getAllCategories();
  }

  //Pega a Lista de categoria que o restaurante possui
  Future<List<Categories>> getRestCategories(int idRest) async{
    return await this._db.getCategorieByIdRest(idRest);
  }

  //Pega todos os restaurantes que tem determinada categoria
  Future<List<Restaurant>> getCategoriesRest(int idCat) async{
    return await this._db.getRestByIdCategories(idCat);
  }

  //Pega todos os pratos do restaurante
  Future<List<Prato>> getPratosRestaurant(int idRest) async {
    return await this._db.getPratos(idRest);
  }

  Future<List<Restaurant>> getListForSearch(String text) async {
    return await this._db.search(text);
  }

  Future<List<Pedido>> getRestPedidos(int idRest) async{
    return await this._db.getPedidosByRest(idRest);
  }

  Future<List<Pedido>> getUserPedidos(int idUser) async {
    return await this._db.getPedidosByUser(idUser);
  } 
  
  Future<List<Restaurant>> getAllRestaurants() async{
    return await this._db.getAllRest();
  }

  Future<List<Restaurant>> getRestaurantsByName() async{
    return await this._db.getAllRest();
  }
  
  Future<List<Restaurant>> getRestPopular() async{
    return await this._db.getRestPopular();
  }

  Future<List<Restaurant>> getRestPromocao() async{
    return await this._db.getRestPromocao();
  }
  
  Future<List<Restaurant>> getRestEntregaGratis() async{
    return await this._db.getRestEntregaGratis();
  }
  
  Future<List<Restaurant>> getRestEntregaRapida() async{
    return await this._db.getRestEntregaRapida();
  }
  
  Future<List<Restaurant>> getRestMaisPedido() async{
    return await this._db.getMaisPedidos();
  }

  Future<List<Pedido>> getRelatorio1day(int idRest) async{
    return await this._db.getRelatorio2_1day(idRest);
  }

  Future<List<Pedido>> getRelatorio7day(int idRest) async{
    return await this._db.getRelatorio2_7days(idRest);
  }

Future<List<Pedido>> getRelatorio15day(int idRest) async{
    return await this._db.getRelatiorio2_15days(idRest);
  }

  Future<Pedido> getRelatorio1(int idRest)async{
    return await this._db.getRelatorio1(idRest);
  }

  Future<bool> removeItemCart(Prato p, int quant) async{
    return await this._db.removeItemCart(p, quant);
  }

  Future<bool> savePedido() async {
    if(this._pratos==null || this._pratos.isEmpty){
      return false;
    }
    Pedido p  = new Pedido(this._pratos,this.user, this._qnt);
    double value = 0;
    for(int i = 0; i < this._pratos.length; i++){
      value += this._pratos[i].preco.preco * this._qnt[i];
    }
    if(isGratis != 1){
      value+=2;
    }
    bool b = await this._db.savePedido(p, value);
    this._pratos= new List<Prato>();
    this._qnt= new List<int>();
    return b;
  }


  void addPrato(Prato p , int q, int gratis){
    if(isGratis==null){
      isGratis=gratis;
    }
    int cont =0;

    for(int i =0 ; i<this._pratos.length; i++){
      if(this._pratos[i].idPrato==p.idPrato){
        this._qnt[i]+=q;
        cont++;
      }
    }
    if(cont>0){
      return;
    }

    this._pratos.add(p);
    this._qnt.add(q);
  }

  void removeItem(int index){
    this._qnt.removeAt(index);
    this._pratos.removeAt(index);
    if(this._qnt.isEmpty){
      this.isGratis = null;
    }
  }

  void clearCart(){
    this._qnt = new List<int>();
    this._pratos = new List<Prato>();
    this.isGratis = null;
  }

  void setUser(User u){
    this.user = u;
  }

  bool canAddPlate(Prato p){
    if(this._pratos.isEmpty){
      return true;
    }
    else if(this._pratos[0].idRest == p.idRest){
      return true;
    }
    return false;
  }


  List<Prato> get plate => this._pratos;
  List<int> get quant => this._qnt;


}