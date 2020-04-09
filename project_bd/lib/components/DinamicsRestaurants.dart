import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeUserPage/restaurantPage.dart';

import '../constants.dart';

class DinamicRestaurants extends StatefulWidget {
  String _name;

  DinamicRestaurants(this._name);

  @override
  State<StatefulWidget> createState() => _DinamicRestaurantsState(this._name);
}

class _DinamicRestaurantsState extends State<DinamicRestaurants> {
  String _name;

  List<Restaurant> _rest = new List<Restaurant>();
  _DinamicRestaurantsState(this._name);

  @override
  void initState() {
    setState(() {
      Control _control = Control();
      Map<String, Future<List<Restaurant>>> map = {
        "Restaurante popular": _control.getRestPopular(),
        "Promoção": _control.getRestPromocao(),
        "Entrega gratis": _control.getRestEntregaGratis(),
        "Entrega rápida": _control.getRestEntregaRapida(),
        "Mais pedidos": _control.getRestMaisPedido()
      };
      map[_name].then((onValue) {
        setState(() {
          _rest = onValue;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getContainer(),
    );
  }

  Widget getContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff38ad53),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 15),
                ),
                Text(
                  '${this._name}'.toUpperCase(),
                  style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text('RESTAURANTES', style: TextStyle(color:Colors.grey.shade500),),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width ,
            child: ListView.builder(
              itemCount: this._rest.length,
              itemBuilder: (BuildContext context, int index) {
                if (this._rest==null) {
                  
                  return Center(
                    child: Text(
                        "Ainda não foi cadastrado nenhum restaurante popular"),
                  );
                } else {
                  return MaterialButton(
                    onPressed: () {
                      _call(this._rest[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1.0, //ext
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10),
                                  bottomLeft: const Radius.circular(10)),
                              child: Image.network(
                                '${this._rest[index].url}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 130,
                            margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                            child: Center(
                              child: Text('${this._rest[index].name}',
                                  style: kTextRest),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _call(Restaurant t) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RestaurantPage(t)));
  }
}
