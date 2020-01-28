import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/data/database.dart';

class SignUpRest extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _SignUpRestState();
}

class _SignUpRestState extends State<SignUpRest>{
  
  bool isLoading;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String pass;
  String name;
  String image;
  String description;
  String nume;
  String email;
  String address;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
                    decoration: InputDecoration(
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )),
                    onSaved: (val) => name = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
                    ),
                    onSaved: (val) => pass =val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'UrlImage',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    )),
                    onSaved: (val)=> image = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Description',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
                    ),
                    onSaved: (val)=> description = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
                    ),
                    onSaved: (val)=> email = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Número',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
                    ),
                    onSaved: (val)=> nume = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Endereço',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
                    ),
                    onSaved: (val)=> address = val,
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
    Restaurant temp =Restaurant(name, pass, null, 0,image, description,nume,email,address);
    db.saveRest(temp);
    Navigator.pop(context);
  }

}