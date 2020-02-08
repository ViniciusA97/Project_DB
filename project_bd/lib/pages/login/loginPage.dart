
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/HomeRestPages/HomeRestPage.dart';
import 'package:project_bd/pages/HomeUserPage/HomeUserPage.dart';
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
      resizeToAvoidBottomInset: false,
      backgroundColor:Colors.white,
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
    User u;
    if(utilUser){
      List<Restaurant> rests = await db.getAllRest();
      u =await db.getUser(email, password);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> HomePageUser(rests,u)));
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
      Restaurant restaurant = await db.getRest(email);
      print(restaurant);
      Navigator.push(context, MaterialPageRoute(builder:(context)=> RestPage(restaurant)));
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
    Column(
      children: <Widget>[
        
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:ListView(
            children: <Widget>[
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: <Widget>[
               Container(
                 child:
                Image.asset('./assets/comida.jpg')
               ),
                Padding(padding: EdgeInsets.only(top:20),),
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  tabs: <Widget>[
                    Tab(text:'User',),
                    Tab(text: 'Restaurante',)
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width-50,
                  child: TabBarView(
                    children: <Widget>[
                      getUserLogin(),
                      getRestauranteLogin(),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Image.asset('./assets/comida2.jpg')

                  ],
                )
              ],
            ),
          )
        ],
      )
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
        Padding(padding: EdgeInsets.all(5),),
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
                  fillColor: Color.fromRGBO(144,238,144, .1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                  ),
                onSaved: (value) => email=value,
              ),
              Padding(padding: EdgeInsets.all(5),),
              TextFormField(
                validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration(
                  hintText: 'password',
                  fillColor: Color.fromRGBO(144,238,144, .1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                  ),
                onSaved: (value)=> password = value,
              ),
              Padding(padding: EdgeInsets.all(5),),
          
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                onPressed: _submitUser,
                child: Text('submit'),
              ),
              FlatButton(
                child: Text('Dont have a User accont?', style: TextStyle(color: Colors.black),),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> SignUp()));
                } ,
              ),


              
            ],
          ),
        ),
      ],
    ));
  }

  Widget getRestauranteLogin(){
    return
    Center(child: 
     Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(5),),
        Form( 
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                scrollPadding: const EdgeInsets.all(200.0),
                validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration(
                  hintText: 'email',
                  fillColor: Color.fromRGBO(144,238,144, .1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )),
                onSaved: (value) => email=value,
              ),
              Padding(padding: EdgeInsets.all(5),),
              TextFormField(
                validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
                decoration: InputDecoration
                (hintText: 'password',
                  fillColor: Color.fromRGBO(144,238,144, .1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )),
                onSaved: (value)=> password = value,
              ),
              Padding(padding: EdgeInsets.all(5),),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                onPressed: _submitRest,
                child: Text('submit'),
              ),
              FlatButton(
                child: Text('Dont have a Restaurant acconte?',style: TextStyle(color: Colors.black)),
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
