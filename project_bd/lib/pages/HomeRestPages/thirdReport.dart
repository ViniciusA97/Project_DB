import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:intl/intl.dart';

class ThirdReport extends StatefulWidget {
  final Restaurant _restaurant;
  ThirdReport(this._restaurant);

  @override
  _ThirdReportState createState() => _ThirdReportState(this._restaurant);
}

class _ThirdReportState extends State<ThirdReport> {
  Restaurant _restaurant;
  _ThirdReportState(this._restaurant);
  List<Prato> _pratos;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    Control control = Control();

    try {
      await control.getRelatorio3(this._restaurant.id).then((onValue) {
        setState(() {
          this._pratos = onValue;
          print(this._pratos[0].name);
        });
      });
    } catch (e) {}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: header(),
    );
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
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
                  'PREÇOS MÉDIOS',
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
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height - 130,
            child: body(),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 140,
              child: getList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget getList() {
    if (this._pratos == null) {
      return Center(
        child: Text('Sem pedidos'),
      );
    } else {
      return ListView.builder(
          itemCount: this._pratos.length,
          itemBuilder: (BuildContext cntx, int index) {
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(
                        'Prato ${this._pratos[index].name}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                      Divider(color: Colors.grey),
                      Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(
                        'Preço Médio R\$ ${this._pratos[index].preco.preco}0',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 7),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }
}
