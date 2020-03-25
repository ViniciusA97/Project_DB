import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeRestPages/cardapioRest.dart';
import 'package:project_bd/pages/HomeRestPages/InitRest.dart';
import 'package:project_bd/data/database.dart';

import 'pedidosRest.dart';

class RestPage extends StatefulWidget {
  Restaurant _rest;
  RestPage(this._rest);
  @override
  State<StatefulWidget> createState() => _RestPageState(_rest);
}

class _RestPageState extends State<RestPage> {
  _RestPageState(this._rests);

  final scaffolKey = GlobalKey<ScaffoldState>();
  Restaurant _rests;
  int current = 0;
  InitRest _homeRest;
  CardapioPage _cardapioPage;
  PedidosRest _pedidosRest;
  List<Widget> pages;
  Widget currentPage;
  int previous = 0;

  @override
  void initState() {
    _cardapioPage = CardapioPage(this._rests.id);
    _homeRest = InitRest(_rests);
    print(_homeRest);
    _pedidosRest = PedidosRest(this._rests);
    pages = [_homeRest, _cardapioPage, _pedidosRest];
    currentPage = _homeRest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(this._rests);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        iconSize: 20,
        selectedFontSize: 12,
        onTap: (index) {
          setState(() {
            current = index;
            if(index == 3)
              delivery(context);
            else
            {
              previous = index;
              currentPage = pages[index];
            }
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: current == 0 ? Color(0xff38ad53) : Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: current == 1 ? Color(0xff38ad53) : Colors.grey,
            ),
            title: Text(
              'Cardapio',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.room_service,
              color: current == 2 ? Color(0xff38ad53) : Colors.grey,
            ),
            title: Text(
              'Pedidos',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.motorcycle,
              color: current == 3 ? Color(0xff38ad53) : Colors.grey,
            ),
            title: Text(
              'Entrega',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  void delivery(context)
  {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                setState(() {
                  this._rests.setEntrega(1);
                  saveDeliveryType(1);
                });
                current = previous;
                Navigator.pop(context);
              },
              color: Color(0xff38ad53),
              child: Text(
                'Entrega Grátis',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                setState(() {
                  this._rests.setEntrega(2);
                  saveDeliveryType(2);
                });
                current = previous;
                Navigator.pop(context);
              },
              child: Text(
                'Entrega rápida',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                current = 0;
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveDeliveryType(int a) async
  {
      var db = DatabaseHelper.internal();
      db.saveEntrega(this._rests, a);
  }

}