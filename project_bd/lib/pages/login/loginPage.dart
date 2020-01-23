import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/home/HomePageUser.dart';
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
      backgroundColor: Colors.red,
      key: scaffoldKey,
      body: home(),
    );
  }

  void _submitUser() async {
      final form = formKey.currentState;
      if(form.validate()){
        setState(() {
          form.save();
          isLoading = true;
        });
      }
      var db = DatabaseHelper();
    bool utilUser = await db.existUser(email,password);
    if(utilUser){
      List<Map> rests = await db.getAllRest();
      Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePageUser(rests)));
    }else{
      _showSnackBar('User dont exist');
    }
  }
  

  void _submitRest() async{
    final form = formKey.currentState;
      if(form.validate()){
        setState(() {
          form.save();
          isLoading = true;
        });
      }
    var db = DatabaseHelper();
    bool utilRest = await db.existRest(email, password);
    if(utilRest){
      List<Map> rests = await db.getAllRest();
      Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePageUser(rests)));
    }else{
      _showSnackBar('Restaurant dont exist');
    }
      
  }


  _showSnackBar(String text){
    final key = scaffoldKey.currentState;
    key.showSnackBar(new SnackBar(content: new Text(text),));
  }

   Widget home(){
    return
     ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0),),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(text:'User'),
                    Tab(text: 'Restaurante',)
                  ],
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: TabBarView(
                    children: <Widget>[
                      getUserLogin(),
                      getRestauranteLogin()
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

  Widget getUserLogin(){
    return 
    Center(

    child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                decoration: InputDecoration(
                  hintText: 'email',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                  ),
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
                decoration: InputDecoration(
                  hintText: 'password',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                  ),
                onSaved: (value)=> password = value,
              ),
              Padding(padding: EdgeInsets.all(10),),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                onPressed: _submitUser,
                child: Text('submit'),
              ),
              FlatButton(
                child: Text('Dont have a User accont?', style: TextStyle(color: Colors.white),),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUp()));
                } ,
              )
            ],
          ),
        )
      ],
    ));
  }

  Widget getRestauranteLogin(){
    return
    Center(child: 
     Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                decoration: InputDecoration(
                  hintText: 'email',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )),
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
                decoration: InputDecoration
                (hintText: 'password',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )),
                onSaved: (value)=> password = value,
              ),
              Padding(padding: EdgeInsets.all(10),),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                onPressed: _submitRest,
                child: Text('submit'),
              ),
              FlatButton(
                child: Text('Dont have a Restaurant acconte?',style: TextStyle(color: Colors.white)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUpRest()));
                },
              )
            ],
          ),
        )
      ],
    ));

  }

  
  
}
