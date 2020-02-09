import 'package:flutter/material.dart';
import 'package:project_bd/pages/login/loginPage.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Map<int, Color> color =
{
50:Color.fromRGBO(0,0,0, .1),
100:Color.fromRGBO(0,0,0, .2),
200:Color.fromRGBO(0,0,0, .3),
300:Color.fromRGBO(0,0,0, .4),
400:Color.fromRGBO(0,0,0, .5),
500:Color.fromRGBO(0,0,0, .6),
600:Color.fromRGBO(0,0,0, .7),
700:Color.fromRGBO(0,0,0, .8),
800:Color.fromRGBO(0,0,0, .9),
900:Color.fromRGBO(0,0,0, 1),
};

  MaterialColor colorCustom = MaterialColor(0x000000, color);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Projeto BD",
      theme: ThemeData(
        primarySwatch: colorCustom,
        primaryColor: Colors.black,
        hintColor: Colors.black),
      home: LoginPage(),
    );
  }
}
