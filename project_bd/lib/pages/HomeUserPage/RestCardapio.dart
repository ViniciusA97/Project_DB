import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';

class RestCardapio extends StatefulWidget{

  Restaurant res;
  RestCardapio(this.res);

  @override
  State<StatefulWidget> createState() => _RestCardapioState(this.res);

}

class _RestCardapioState extends State<RestCardapio>{

  Restaurant rest;
  _RestCardapioState(this.rest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
                Image.network('${this.rest.url}', width: MediaQuery.of(context).size.width, height: 250,fit: BoxFit.fill,),
                Positioned(
                  top: 150,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('${this.rest.name}')
                          ],
                        )
                      ],
                    ),

                  )
                )
            ],
          )
        ],
      ),
    );
  }

}