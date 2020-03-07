import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scafolldKey,
      body: Center(
        child:Column(
          children: <Widget>[
            new Form(
              key: formKey,
              child:
              Container(
                height: MediaQuery.of(context).size.height/4*3,
                width: MediaQuery.of(context).size.width,

              child:
              Column(
                
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text('Create your Restaurant Account',style: TextStyle(fontSize: 20),),
                  Padding(padding: EdgeInsets.only(top:20),),
                  
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
              ]))),
              
              Container(
                height: MediaQuery.of(context).size.height/4,
                child:
                Stack(
                 
                children: <Widget>[
                  Positioned(
                    child:
                    new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Image.asset('./assets/comida3.jpg'),
                    )
                    
                  )
                  
                  ],

               )
                
              ) ,
          ])
            
            
      )
      
    );
  }

  void _create() async {
    final form = formKey.currentState;
      if(form.validate()){
        setState(() {
          form.save();
          isLoading = true;
        });
      }
    Control control = Control.internal();
    Restaurant temp =Restaurant(name, pass, null, 0,image, description,nume,email,address);
    bool condiction = await control.saveRest(temp);
    if(condiction){
      Navigator.pop(context);
    }else{
      _showSnackBar('Email ou nome ja utilizados.');
      
    }
  }

  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }


}