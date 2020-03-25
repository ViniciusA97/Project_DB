import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/data/database.dart';

class InitRest extends StatefulWidget {
  Restaurant _restaurant;


  InitRest(this._restaurant);

  State<StatefulWidget> createState() => _InitRestState(_restaurant);
}

class _InitRestState extends State<InitRest> {
  _InitRestState(this._rest);

  //atributos
  Restaurant _rest;
  List<Categories> _categories;
  List<Categories> _allCategories;
  String type;

  //keys
  final key = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //variaveis para criar categorias
  String name;
  String img;

  //variaveis utilizadas no AnimedContainer
  Alignment alignment = Alignment.bottomCenter;
  double x = 0;
  bool isSubindo = false;
  Widget _search = Container(
    width: 0,
    height: 0,
  );
  Widget _create = Container(
    width: 0,
    height: 0,
  );
  Widget tab = Container(
    width: 0,
    height: 0,
  );

  @override
  void initState() {
    _asyncMetod();
    this._categories = _rest.categories;
    super.initState();
  }

  _asyncMetod() async {
    Control control = Control.internal();
    control.getAllCategories().then((onValue) {
      setState(() {
        this._allCategories = onValue;
      });
    });
  }

  _showSnackBar(String text) {
    final key = scaffoldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: body(),
      //drawer: getDrawer(),
    );
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Positioned(
                    child: ClipRRect(
                      child: Image.network(
                        '${this._rest.url}',
                        fit: BoxFit.fill,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(20),
                          bottomRight: const Radius.circular(20),
                          topLeft: const Radius.circular(20),
                          topRight: const Radius.circular(20),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height - 400,
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
                                color: Colors.grey,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${this._rest.name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    '${this._rest.tipoEntrega}',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${this._rest.email}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    '${this._rest.nume}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 10,
                color: Colors.grey.shade100,
              ),
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Categorias',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    getListView(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Container(
                height: 10,
                color: Colors.grey.shade100,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: AnimatedContainer(
                    height: x,
                    child: tab,
                    duration: Duration(milliseconds: 700),
                    curve: Curves.fastOutSlowIn,
                    alignment: alignment,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                      ),
                      color: Colors.grey.shade100,
                    ),
                    onEnd: () {
                      setState(() {
                        if (isSubindo) {
                          print('a');
                          _setCreate();
                          _setSerch();
                          _getTabView();
                        } else {
                          print('b');
                          this._search = Container(
                            height: 0,
                            width: 0,
                          );
                          this._create = Container(
                            height: 0,
                            width: 0,
                          );
                          this.tab = Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget getListView() {
    if (this._categories == null) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15),
            height: 126,
            width: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: FlatButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  x = 350;
                  alignment = Alignment.center;
                  isSubindo = true;
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            'Adicione uma categoria',
            style: kTextCategorie,
          )
        ],
      );
    } else if (this._categories.length == 0) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 125,
            width: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100,
            ),
            child: FlatButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  x = 350;
                  alignment = Alignment.center;
                  isSubindo = true;
                });
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            'Adicione uma categoria',
            style: kTextCategorie,
          )
        ],
      );
    } else {
      return SizedBox(
        height: 164,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this._categories.length + 1,
          itemBuilder: (BuildContext cntx, int index) {
            print(index);
            if (index == 0) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 126,
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          x = 350;
                          alignment = Alignment.center;
                          isSubindo = true;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    'Adicione uma categoria',
                    style: kTextCategorie,
                  )
                ],
              );
            }
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  height: 136,
                  width: 190,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      this._categories[index - 1].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('${this._categories[index - 1].name}',
                    style: kTextCategorie),
              ],
            );
          },
        ),
      );
    }
  }

  _setCreate() {
    setState(() {
      this._create = Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: kTextFieldDecoraction.copyWith(
                      hintText: "Nome da categoria"),
                  onSaved: (val) => name = val,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                TextFormField(
                  decoration: kTextFieldDecoraction.copyWith(
                      hintText: "Imagem da categoria"),
                  onSaved: (val) => img = val,
                ),
                Padding(padding: EdgeInsets.only(top: 25)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xff38ad53),
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        _save();
                        setState(() {
                          isSubindo = false;
                          x = 0;
                          this._search = Container(
                            height: 0,
                            width: 0,
                          );
                          this._create = Container(
                            height: 0,
                            width: 0,
                          );
                          tab = Container(
                            height: 0,
                            width: 0,
                          );
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 5, 0, 0)),
                    RaisedButton(
                      color: Color(0xff38ad53),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        setState(() {
                          isSubindo = false;
                          x = 0;
                          this._search = Container(
                            height: 0,
                            width: 0,
                          );
                          this._create = Container(
                            height: 0,
                            width: 0,
                          );
                          tab = Container(
                            height: 0,
                            width: 0,
                          );
                        });
                      },
                    ),
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
        height: 400,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              child: ListView.builder(
                itemCount: this._allCategories.length,
                itemBuilder: (BuildContext cntx, int index) {
                  if (this._categories == null) {
                    return Center(
                      child: Text('Sem categorias cadastradas'),
                    );
                  }
                  return RawMaterialButton(
                    onPressed: () {
                      addCategories(index);
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              bottomLeft: const Radius.circular(20),
                            ),
                            child: Image.network(
                              '${this._allCategories[index].image}',
                              width: 120,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          Text('${this._allCategories[index].name}')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 0, 0)),
            RaisedButton(
              color: Color(0xff38ad53),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                setState(() {
                  isSubindo = false;
                  x = 0;
                  this._search = Container(
                    height: 0,
                    width: 0,
                  );
                  this._create = Container(
                    height: 0,
                    width: 0,
                  );
                  tab = Container(
                    height: 0,
                    width: 0,
                  );
                });
              },
            ),
          ],
        ),
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
      db.saveRelacionCatRest(this._rest.id, cat.id);
      List<Categories> list = await db.getCategorieByIdRest(this._rest.id);
      setState(() {
        this._categories = list;
        x = 0;
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
          Text(
            'Categorias',
            style: kTextCategorie,
          ),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Color(0xff38ad53),
                  tabs: <Widget>[
                    Tab(
                      child: Text('Create'),
                    ),
                    Tab(
                      child: Text('Search'),
                    )
                  ],
                ),
                Container(
                  height: 270,
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

  void addCategories(int index) async {
    Categories cat = this._allCategories[index];
    DatabaseHelper db = DatabaseHelper.internal();
    await db.saveRelacionCatRest(this._rest.id, cat.id).catchError(() {
      _showSnackBar('Não foi possivel adicionar a categoria ao restaurante.');
    }).then((onValue) {
      this.setState(() {
        this._categories.add(this._allCategories[index]);
      });
    });
  }
}