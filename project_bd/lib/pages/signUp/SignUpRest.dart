import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';

class SignUpRest extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _SignUpRestState();
}

class _SignUpRestState extends State<SignUpRest>{
  
  bool isLoading;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  int pass;
  String name;
  String image;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafolldKey,
      appBar: AppBar(title: Text("Create a Restaurant a accont"),),
      body: Center(
        child:Column(
          children: <Widget>[
            new Form(
              key: formKey,
              child:Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (val) => name = val,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password',),
                    onSaved: (val) => pass = int.parse(val),
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Url Image'),
                    onSaved: (val)=> image = val,
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
          isLoading = true;
        });
      }

    DatabaseHelper db = DatabaseHelper();
    Restaurant temp =Restaurant(name, pass, null, 0,image);
    db.saveRest(temp);
    Navigator.pop(context);
  }

}