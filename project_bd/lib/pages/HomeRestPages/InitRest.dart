import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/data/database.dart';

class InitRest extends StatefulWidget {
  @override
  InitRest(this._restaurant);

  State<StatefulWidget> createState() => _InitRestState(_restaurant);
  Restaurant _restaurant;
}

class _InitRestState extends State<InitRest> {
  _InitRestState(this._rest);

  Restaurant _rest;
  List<Categories> _categories;

  @override
  void initState() {
    _initCategories;
    super.initState();
  }

  _initCategories() async{
    var db = DatabaseHelper.internal();
    this._categories = await db.getCategorieByIdRest(_rest.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
      //drawer: getDrawer(),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Positioned(child: Image.network('${this._rest.url}')),
            Positioned(
              top: 150,
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(20),
                        bottomRight: const Radius.circular(20),
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20))),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${this._rest.address}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            '${this._rest.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('${this._rest.email}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                                Text('${this._rest.nume}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey))
                              ],
                            ),
                          ),
                        ])),
              ),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Categorias',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.start,
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                getListView(),
              ],
            )

            // child: allWidgetRest(),
            )
      ],
    );
  }

  Widget getListView(){
    
  }

}
