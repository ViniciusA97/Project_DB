import 'package:flutter/material.dart';
import 'package:project_bd/Pratos.dart';
import 'package:project_bd/pages/login/loginPage.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Projeto BD",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginPage(),
    );
  }
}
