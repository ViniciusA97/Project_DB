import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';

class RestPage extends StatefulWidget{
  Restaurant _rest;
  
  RestPage(this._rest);
  @override
  State<StatefulWidget> createState() => _RestPageState(_rest);

}
class _RestPageState extends State<RestPage>{
 

  final scaffolKey = GlobalKey<ScaffoldState>();
  Restaurant _rests;
  int currentIndex;
  _RestPageState(this._rests);

  @override
  Widget build(BuildContext context) {
    print(this._rests);
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.red,
      body:  test(),
      
    );

  }

  Widget test(){
    print(_rests);

    return 
    Column(
       mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[   
          
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(20), bottomRight: const Radius.circular(20),topLeft: const Radius.circular(20),topRight: const Radius.circular(20))
            ),
            width: MediaQuery.of(context).size.width,
            child: Image.network(_rests.url),
          ),
        
        Padding(padding: EdgeInsets.only(top: 15),),
      
           Container(
            width: MediaQuery.of(context).size.width-30,
            child: Text('${this._rests.name}', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
            color: Colors.white,
        
          ),
        
    
    ]);
    
  } 
}
