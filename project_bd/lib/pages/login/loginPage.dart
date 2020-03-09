import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeRestPages/HomeRestPage.dart';
import 'package:project_bd/pages/HomeUserPage/HomeUserPage.dart';
import 'package:project_bd/pages/signUp/SignUpRest.dart';
import 'package:project_bd/components/userForm.dart';
import 'package:project_bd/pages/signUp/signUp.dart';
import 'package:project_bd/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: home(),
    );
  }

  Widget home() {
    return Column(
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
                        children: <Widget>[Image.asset('./assets/comida2.jpg')],
                      )
                    ],
                  ),
                )
              ],
            ))
      ],
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
          UserForm(email: email, password: password, submitUser: _submitUser, isRest: true),
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
          UserForm(email: email, password: password, submitRest: _submitRest, isRest: false),
        ],
      ),
    );
  }

  void _submitUser() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });
    }
    var control = Control.internal();
    var user = await control.doLogin(email, password);
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePageUser(user)));
    } else {
      _showSnackBar('User dont exist');
    }
  }

  void _submitRest() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });
    } else {
      return;
    }
    var control = Control.internal();
    Restaurant rest = await control.doLoginRestaurant(email, password);
    if (rest != null) {
      List<Categories> cat = await control.getAllCategories();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RestPage(rest)));
    } else {
      _showSnackBar('Restaurant dont exist');
    }
  }

  _showSnackBar(String text) {
    final key = scaffoldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}

