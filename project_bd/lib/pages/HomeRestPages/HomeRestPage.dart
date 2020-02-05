import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/HomeRestPages/CardapioRest.dart';
import 'package:project_bd/pages/HomeRestPages/InitRest.dart';

import 'pedidosRest.dart';

class RestPage extends StatefulWidget{
  Restaurant _rest;
  
  RestPage(this._rest);
  @override
  State<StatefulWidget> createState() => _RestPageState(_rest);

}
class _RestPageState extends State<RestPage>{
 

  _RestPageState(this._rests);

  final scaffolKey = GlobalKey<ScaffoldState>();
  Restaurant _rests;
  int current = 0;
  InitRest _homeRest ;
  CardapioPage _cardapioPage;
  PedidosRest _pedidosRest;
  List<Widget> pages;
  Widget currentPage;


  @override
  void initState() {
    _cardapioPage = CardapioPage(this._rests.cardapio,this._rests.id);
    _homeRest = InitRest(_rests);
    _pedidosRest = PedidosRest(this._rests);
    pages=[_homeRest, _cardapioPage, _pedidosRest];
    currentPage = _homeRest;
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    print(this._rests);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffolKey,
      backgroundColor: Colors.white,
      body:currentPage ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        onTap: (int index){
          setState((){
            current = index;
            currentPage= pages[index];
            });
        },
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home) , title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Cardapio')),
          BottomNavigationBarItem(icon: Icon(Icons.room_service), title: Text('Pedidos'))
        ] ,

      )
    );

  } 
}