import 'dart:ffi';

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
      //drawer: getDrawer(),
    );
  }

  Drawer getDrawer(){
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
        children: <Widget>[
           Image.network('${this._rest.url}'),
           ListTile(
             title:Text('${this._rest.address}')
           ),
           ListTile(
            title:Text('${this._rest.name}',style: TextStyle(fontSize:25),textAlign: TextAlign.center,)
           ),
           Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               RaisedButton(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                 child: Text('Sign Out'),
                 onPressed:(){
                   Navigator.pop(context);
                 }
               )
             ],
           )
            
          
        ],),
    );
  }

  Widget body(){
    return 
      Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Positioned(
              child: Image.network('${this._rest.url}')
            ),
            Positioned(
              top:150,
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(20), bottomRight: const Radius.circular(20),topLeft: const Radius.circular(20),topRight: const Radius.circular(20))
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.only(top:10,left: 10),
                  child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${this._rest.address}', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey),),
                        Padding(padding: EdgeInsets.only(top:5)),
                        Text('${this._rest.name}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25), ),
                        Container(
                          margin: EdgeInsets.only(top:10,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${this._rest.email}', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey)),
                              Text('${this._rest.nume}', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey))
                            ],
                          ),
                        ),
                        
                    ]                      
                  ) 
                ),
              ),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top:5)),
        
        Container(
          height: 10,
          color: Colors.grey.shade100,
        )
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