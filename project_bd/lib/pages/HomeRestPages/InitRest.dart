import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';

class InitRest extends StatefulWidget{
  @override

  InitRest(this._restaurant);

  State<StatefulWidget> createState() => _InitRestState(_restaurant);
  Restaurant _restaurant;
}

class _InitRestState extends State<InitRest>{

  _InitRestState(this._rest);

  Restaurant _rest;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:30)),
              Text('${_rest.name}',style: TextStyle(fontSize: 30),),
              Padding(padding: EdgeInsets.only(top:20)),

              Image.network(_rest.url),
             Container( 
               margin: EdgeInsets.only(top:10,bottom:10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('${_rest.address}',style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),

                  ],
                ),
              ),
              

              Padding(padding: EdgeInsets.only(top:20)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Color.fromRGBO(233, 233, 233, 1),
                child: Text('${_rest.descriprion}',textAlign: TextAlign.center,),
              )
              ,
              Padding(padding: EdgeInsets.only(top:20)),
              
              Padding(padding: EdgeInsets.only(top:20)),
              Text('${_rest.email}')


            ],
          ),

        ),

      ],

    );
  }

  Widget test(){

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
            child: Image.network(_rest.url),
          ),
        
        Padding(padding: EdgeInsets.only(top: 15),),
      
           Container(
            width: MediaQuery.of(context).size.width-30,
            child: Text('${this._rest.name}', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
            color: Colors.white,
        
          ),
        
    
    ]);
  }

}