import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _SignUpState();
}

class _SignUpState extends State<SignUp>{
  
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String email;
  String pass;
  String number;
  String name;
  String address;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      appBar: AppBar(title: Text("Create a user a accont"),),
      body: Center(
        child:Column(
          children: <Widget>[
            Form(
              key: formKey,
              child:Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (val) => name = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (val) => email = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password',),
                    onSaved: (val) => pass = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Number'),
                    onSaved: (val) => number = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address'),
                    onSaved: (val) => address = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  RaisedButton(
                    onPressed:_create,
                    child: Text('Create'),
                  )
                ],
              ) ,
            )
          ],
        ) ,
      ),
    );
  }

  void _create(){
    final form = formKey.currentState;
      if(form.validate()){
        setState(() {
         form.save();
         isLoading=true;
      });
      }

    DatabaseHelper db = DatabaseHelper();
    User temp =User( name, pass, email,address, number);
    db.saveUser(temp);
    Navigator.pop(context);
  }

}