import 'package:flutter/material.dart';
import 'package:project_bd/Pratos.dart';
import 'package:project_bd/pages/login/loginPage.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Map<int, Color> color =
{
50:Color.fromRGBO(255,255,255, .1),
100:Color.fromRGBO(255,255,255, .2),
200:Color.fromRGBO(255,255,255, .3),
300:Color.fromRGBO(255,255,255, .4),
400:Color.fromRGBO(255,255,255, .5),
500:Color.fromRGBO(255,255,255, .6),
600:Color.fromRGBO(255,255,255, .7),
700:Color.fromRGBO(255,255,255, .8),
800:Color.fromRGBO(255,255,255, .9),
900:Color.fromRGBO(255,255,255, 1),
};

  MaterialColor colorCustom = MaterialColor(0xFF880E4F, color);
    return MaterialApp(
      title: "Projeto BD",
      theme: ThemeData(primarySwatch: colorCustom,primaryColor: Colors.white),
      home: LoginPage(),
    );
  }
}
