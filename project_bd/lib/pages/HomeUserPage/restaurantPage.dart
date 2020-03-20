import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeUserPage/platePage.dart';

class RestaurantPage extends StatefulWidget {
  Restaurant _restaurant;
  RestaurantPage(this._restaurant);

  @override
  _RestaurantPageState createState() => _RestaurantPageState(_restaurant);
}

class _RestaurantPageState extends State<RestaurantPage> {
  Restaurant _restaurant;
  List<Prato> _pratos = List<Prato>();
  _RestaurantPageState(this._restaurant);

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    Control control = Control.internal();
    await control.getPratosRestaurant(this._restaurant.id).then((onValue) {
      setState(() {
        this._pratos = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
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
                    child: ClipRect(
                      child: Image.network(
                        '${this._restaurant.url}',
                        fit: BoxFit.fill,
                        height: 290,
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
                              '${this._restaurant.address}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Text(
                              '${this._restaurant.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Text(
                              '${this._restaurant.nume}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.motorcycle,
                                  color: Color(0xff38ad53),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                ),
                                // TODO: pegar o tipo de entrega do restaurante
                                Text("Entrega"),
                              ],
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 300,
                padding: EdgeInsets.fromLTRB(3, 0, 5, 0),
                child: showCardapio(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showCardapio() {
    return ListView.builder(
      itemCount: this._pratos.length,
      itemBuilder: (BuildContext cntx, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PlatePage(this._pratos[index])),);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${this._pratos[index].name}', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('${this._pratos[index].descricao}'),
                          Text('\$${this._pratos[index].preco.preco}'),
                        ],
                      ),
                    ),
                      Image.network(
                      '${this._pratos[index].img}',
                      width: 100,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 10)),
              ],
            ),
          ),
        );
      },
      // TODO: add pratos do resturante
    );
  }
}