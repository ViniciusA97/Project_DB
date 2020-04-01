import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/pages/HomeUserPage/HomeUserPage.dart';
import 'package:project_bd/pages/HomeUserPage/userRequest.dart';

class InitUser extends StatefulWidget {
  User _user;

  InitUser(this._user);

  @override
  _InitUserState createState() => _InitUserState(this._user);
}

class _InitUserState extends State<InitUser> {
  _InitUserState(this._user);

  //TODO: Adicionar as páginas da sacola e dos pedidos

  final scaffolKey = GlobalKey<ScaffoldState>();
  User _user;
  int current = 0;
  HomePageUser _homeUser;
  Requests _userReqs;
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    Control control = Control();
    control.setUser(this._user);
    _homeUser = HomePageUser(this._user);
    _userReqs = Requests(this._user);
    pages = [_homeUser, _userReqs];
    currentPage = _homeUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current,
        onTap: (int index) {
          setState(() {
              current = index;
              currentPage = pages[index];
            },
          );
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xff38ad53),
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
              color: Color(0xff38ad53),
            ),
            title: Text(
              'Pedidos',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
