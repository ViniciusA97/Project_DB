import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeRestPages/InitRest.dart';

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
  List<Widget> pages;
  Widget currentPage;


  @override
  void initState(){
    _homeRest = InitRest(_rests);
    pages=[_homeRest];
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