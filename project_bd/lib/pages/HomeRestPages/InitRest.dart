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
  double x = 0;
  final key = GlobalKey<FormState>();
  Alignment alignment = Alignment.bottomCenter;
  String name;
  String img;
  String search;
  Widget _search = Container(
    width: 0,
    height: 0,
  );
  Widget _create = Container(
    width: 0,
    height: 0,
  );
  Widget tab =Container(width: 0,height: 0,);

  @override
  void initState() {
    _initCategories;
    super.initState();
  }

  _initCategories() async {
    var db = DatabaseHelper.internal();
    this._categories = await db.getCategorieByIdRest(_rest.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: body(),
      //drawer: getDrawer(),
    );
  }

  Widget body() {
    return Stack(children: <Widget>[
      Container(
        child: Column(children: <Widget>[
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            height: 120,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                Padding(padding: EdgeInsets.only(top: 10)),
                getListView(),
              ],
            ),
          ),
        ]),
      ),
      // child: allWidgetRest(),

      Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Stack(children: <Widget>[
          Positioned(
              child: AnimatedContainer(
                  alignment: alignment,
                  onEnd: (){
                    _setCreate();
                    _setSerch();
                    _getTabView();
                  },
                  duration: Duration(seconds: 1),
                  height: x,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.grey.shade100),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: tab))
        ]),
      ])
    ]);
  }

  Widget getListView() {
    if (this._categories == null) {
      return Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: FlatButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  x = 290;
                  alignment = Alignment.center;
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 3)),
          Text(
            'Adicione uma categoria',
            style: TextStyle(fontSize: 8),
          )
        ],
      );
    } else {
      setState(() {});
      return ListView.builder(
          itemCount: this._categories.length,
          itemBuilder: (BuildContext cntx, int index) {
            return Column(
              children: <Widget>[
                Container(
                  child: Image.network(this._categories[index].image),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                ),
                Text('${this._categories[index].name}')
              ],
            );
          });
    }
  }

   _setCreate() {
    setState(() {
      this._create = Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Nome da categoria',
                      fillColor: Colors.white,
                      filled: false),
                  onSaved: (val) => name = val,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Imagem da categoria',
                      fillColor: Colors.white,
                      filled: false),
                  onSaved: (val) => img = val,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        child: Text('Create'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          _save();
                          setState(() {
                            x=0;
                            this._search= Container(height: 0,width: 0,);
                            this._create= Container(height: 0,width: 0,);
                            tab = Container(height: 0,width: 0,);

                          });
                        }),
                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 0, 0)),
                    RaisedButton(
                        child: Text('Cancel'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          setState(() {
                            x=0;
                            this._search= Container(height: 0,width: 0,);
                            this._create= Container(height: 0,width: 0,);
                            tab = Container(height: 0,width: 0,);
                            
                          });
                        })
                  ],
                )
              ],
            ),
          ));
    });
  }

  void _setSerch() {
    setState(() {
      this._search = Container(
        width: MediaQuery.of(context).size.width - 20,
      );
    });
  }

  void _save() async {
    final keyState = key.currentState;
    if (keyState.validate()) {
      setState(() {
        keyState.save();
      });
      var db = DatabaseHelper.internal();
      Categories cat = await db.saveCategoria(name, img);
      db.relacionCatRest(this._rest.id, cat.id);
      List<Categories> list = await db.getCategorieByIdRest(this._rest.id);
      setState(() {
        this._categories = list;
        x = 0;
        print('foi');
      });
    }
  }

  _getTabView() {
    setState(() {
      tab = Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text('Categorias'),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                        child: Text('Search',
                            style: TextStyle(color: Colors.black)))
                  ],
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    children: <Widget>[this._create, this._search],
                  ),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
