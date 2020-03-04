import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
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
      resizeToAvoidBottomInset: false,
      key: scafolldKey,
      body: Center(
        child:Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/3*2,
              child: 
              Form(
                key: formKey,
                child:Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20),),
                    Text('Create your account',style: TextStyle(fontSize: 20),),
                    Padding(padding: EdgeInsets.only(top: 20),),
                    TextFormField(
                      decoration: InputDecoration(
                      hintText: 'name',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(20)
                      )
                      ),
                      onSaved: (val) => name = val,
                    
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'email',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    
                      onSaved: (val) => email = val,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'password',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                    onSaved: (val) => pass = val,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'number',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      onSaved: (val) => number = val,
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'address',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      onSaved: (val) => address = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20),),
                    RaisedButton(
                      color: Colors.white,
                      onPressed:_create,
                      child: Text('Create'),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20),),
                  ],
                )
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/3,
              child:Stack(
                 
                  children: <Widget>[
                    Container(
                      child:
                    Positioned(
                      child:
                      new Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Image.asset('./assets/comida4.jpg'),
                    )
                    
                  )
                    )
                  ],

               ))
                ],
              ) ,
            )
          
        
      
    );
  }

  void _create() async{
    final form = formKey.currentState;
      if(form.validate()){
        setState(() {
         form.save();
         isLoading=true;
      });
      }
    Control control = Control.internal();
    User temp =User( name, pass, email,address, number);
    bool confirmate = await control.saveUser(temp);
    if(confirmate){
      Navigator.pop(context);
    }
    else{
      _showSnackBar('Erro! Preencha os campos ou troque o email');
    }
    
  }
  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

}