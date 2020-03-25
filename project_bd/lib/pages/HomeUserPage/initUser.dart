import 'package:flutter/material.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/pages/HomeUserPage/HomeUserPage.dart';

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
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    _homeUser = HomePageUser(this._user);
    pages = [_homeUser];
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
              Icons.room_service,
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
