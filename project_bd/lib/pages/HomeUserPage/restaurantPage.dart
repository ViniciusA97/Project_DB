import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeUserPage/platePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${this._restaurant.nume}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      this._restaurant.gethorario(context),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.motorcycle,
                                    color: Color(0xff38ad53),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                  ),
                                  Text(
                                    '${this._restaurant.tipoEntrega}', 
                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                                  ),
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
                  padding: EdgeInsets.fromLTRB(3, 5, 5, 0),
                  child: showCardapio(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showCardapio() {
    if(!checkIfOpen()) 
    {
      return Center(
        child: Text('Restaurante fechado'),
      );
    }
    if (this._pratos == null) {
      return Center(
        child: Text('Sem pratos cadastrados'),
      );
    }
    else {
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
      );
    }
    
  }

  bool checkIfOpen()
  {
    TimeOfDay close = TimeOfDay.fromDateTime(this._restaurant.horaFecha);
    TimeOfDay open = TimeOfDay.fromDateTime(this._restaurant.horaAbre);

    double oTime = open.hour.toDouble() + (open.minute.toDouble()/60);
    print(oTime);
    double cTime = close.hour.toDouble() + (close.minute.toDouble()/60);
    print(cTime);
    double nTime = TimeOfDay.now().hour.toDouble() + (TimeOfDay.now().minute.toDouble()/60);
    print(nTime);

    if((cTime > oTime && nTime >= oTime && nTime <= cTime || cTime < oTime && 
        (nTime >= oTime|| nTime <= cTime)))
    {
      return true;
    }

    return false;
  }
}