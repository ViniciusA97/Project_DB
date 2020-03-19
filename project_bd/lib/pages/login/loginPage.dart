import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/components/userForm.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: home(),
    );
  }

  Widget home() {
    return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          Container(child: Image.asset('./assets/comida.jpg')),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          TabBar(
                            isScrollable: true,
                            labelColor: Colors.black,
                            indicatorColor: Color(0xff38ad53),
                            tabs: <Widget>[
                              Tab(
                                text: 'User',
                              ),
                              Tab(
                                text: 'Restaurant',
                              )
                            ],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width - 50,
                            child: TabBarView(
                              children: <Widget>[
                                getUserLogin(),
                                getRestauranteLogin(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[Image.asset('./assets/comida4.jpg')],
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
    );
  }

  Widget getUserLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          UserForm(isRest: false),
        ],
      ),
    );
  }

  Widget getRestauranteLogin() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          // Classe em components
          UserForm(isRest: true),
        ],
      ),
    );
  }


  _showSnackBar(String text) {
    final key = scaffoldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}

