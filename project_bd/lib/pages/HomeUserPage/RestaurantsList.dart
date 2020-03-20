import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/Preco.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/HomeUserPage/RestForRestaurantsPage.dart';

//import 'HomeRestPage.dart';

class RestaurantsList extends StatefulWidget {
  int _id;
  List<Restaurant> _restaurants;
  RestaurantsList(this._restaurants);
  @override
  State<StatefulWidget> createState() =>
      _RestaurantsListState(this._restaurants);
}

class _RestaurantsListState extends State<RestaurantsList> {
  _RestaurantsListState(this._restaurants);
  int _id;
  String name;
  String img;
  double precoValue;
  String descricao;
  List<Restaurant> _restaurants;

  final formKey = new GlobalKey<FormState>();
  bool loading = false;

  //_RestaurantsListState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 70)),
          Text(
            "Restaurantes buscados",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: kTextTitle.copyWith(fontSize: 20.0),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          getRestaurantsList(),
          Container(
            height: MediaQuery.of(context).size.height / 2.313,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Image.asset('./assets/comida5.jpg'),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getRestaurantsList() {
    if (this._restaurants == null) {
      return Center(
        child: Text('Nenhum restaurante foi encontrado.'),
      );
    } else {
      return Container(
        width: 400,
        height: 400,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: this._restaurants.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              child: FlatButton(
                onPressed: () => callRest(this._restaurants[index]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      '${this._restaurants[index].name}'
                              .substring(0, 1)
                              .toUpperCase() +
                          '${this._restaurants[index].name}'
                              .substring(1)
                              .toLowerCase(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),

                    //Lembrar de trocar a próxima linha pela de baixo assim que tratar o erro no banco.
                    Text(
                      'Av. Pres. Epitácio Pessoa',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(190, 190, 190, 1),
                      ),
                    ),
                    //Text('${this._restaurants[index].address}'.substring(0,1).toUpperCase()+'${this._restaurants[index].address}'.substring(1).toLowerCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromRGBO(190,190,190,1),),),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  void callRest(Restaurant r) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RestForRestaurantsPage(r)));
  }
}