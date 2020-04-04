import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';

class FirstReport extends StatefulWidget {

  final Restaurant _restaurant;
  FirstReport(this._restaurant);

  @override
  _FirstReportState createState() => _FirstReportState(this._restaurant);
}

class _FirstReportState extends State<FirstReport> {

  final Restaurant _restaurant;
  _FirstReportState(this._restaurant);

  Pedido _pedido;
  Prato _prato;


  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    Control control = Control();
    await control.getRelatorio1(this._restaurant.id).then((onValue) {
      setState(() {
        this._pedido = onValue;
        print(this._pedido);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page());
  }

  Widget page() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Container(
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
                      right: MediaQuery.of(context).size.width / 9,
                    ),
                  ),
                  Text(
                    'Detalhes do item',
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
            plate(),
          ],
        ),
      ),
    );
  }

  Widget plate() {

    if(this._pedido == null){
      return Center(
        child: Text('Você não vendeu nenhum prato'),
      );
    }
    else{
      return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              '${this._pedido.prato[0].img}',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Text(
            '${this._pedido.prato[0].name}',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text(
            '${this._pedido.prato[0].descricao}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            '\$${this._pedido.prato[0].preco.preco}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text(
            'Quantidade de vez(es): ${this._pedido.qnt[0]}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
    }
  }
}