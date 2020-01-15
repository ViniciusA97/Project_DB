import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/home/HomePage.dart';
import 'package:project_bd/pages/signUp/SignUpRest.dart';
import 'package:project_bd/pages/signUp/signUp.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
  

}

class _LoginPageState extends State<LoginPage>{
 
 
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  String password;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LoginPage'),),
      key: scaffoldKey,
      body: login(),
    );
  }

  Widget login(){

    return Column(
      children: <Widget>[
        Text('Do your Login'),
        Padding(padding: EdgeInsets.all(10),),
        Form( 
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration(labelText: 'email'),
                onSaved: (value) => email=value,
              ),
              Padding(padding: EdgeInsets.all(10),),
              TextFormField(
                validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration(labelText: 'passord'),
                onSaved: (value)=> password = value,
              ),
              Padding(padding: EdgeInsets.all(10),),
              RaisedButton(
                onPressed: _submit,
                child: Text('submit'),
                ),
                Padding(padding: EdgeInsets.all(7),),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                child: Text('Dont have a user account? Click Here'), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUp()));
                },
              ),
              FlatButton(
                child: Text('Dont have a restaurant account? Click Here'), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpRest()));
                },
              )
                ],
              )
            ],
          )          
        )
      ],
    );

  }

  void _submit(){
      final form = formKey.currentState;
      if(form.validate()){
        setState(() {
          form.save();
          isLoading = true;
        });
      }
    testLogin(email,password);
  }

  _showSnackBar(String text){
    final key = scaffoldKey.currentState;
    key.showSnackBar(new SnackBar(content: new Text(text),));
  }

  testLogin(String email, String password) async{

    setState(() {
      isLoading=true;
    });

    var db = DatabaseHelper();
    bool utilUser = await db.existUser(email,password);
    bool utilRest = await db.existRest(email, password);
    if(utilUser || utilRest){
      List<Map> rests = await db.getAllRest();
      Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePage(rests)));
    }else{
      _showSnackBar('User dont exist');
    }
  }

  
  
}
