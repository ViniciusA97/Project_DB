import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';

class Control{

  final DatabaseHelper _db = DatabaseHelper.internal();

  static final Control _instance = new Control.internal();
  factory Control() => _instance;
  Control.internal();

  
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
  
  Future<List<Restaurant>> getRestMaisPedido() async{}

}