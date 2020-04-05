import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/pages/HomeRestPages/firstReport.dart';
import 'package:project_bd/pages/HomeRestPages/secondReport.dart';
import 'package:project_bd/pages/HomeRestPages/thirdReport.dart';

class ReportsPage extends StatefulWidget {

  Restaurant _restaurant;
  ReportsPage(this._restaurant);

  @override
  _ReportsPageState createState() => _ReportsPageState(this._restaurant);
}

class _ReportsPageState extends State<ReportsPage> {

  Restaurant _restaurant;
  _ReportsPageState(this._restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: header(),
    );
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2,
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
                    right: MediaQuery.of(context).size.width / 7,
                  ),
                ),
                Text(
                  'RELATÓRIOS',
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
          body(),
        ],
      ),
    );
  }


  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FirstReport(_restaurant)));
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                        Icon(Icons.fastfood, size: 25, color: Colors.grey),
                        Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Prato mais pedido',
                              style: kTextMenu,
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Visualize qual foi o seu prato mais pedido',
                              textAlign: TextAlign.justify,
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: Color(0xff38ad53),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondReport(_restaurant)));
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30),),
                        Icon(Icons.receipt, size: 25, color: Colors.grey),
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Extratos dos pedidos',
                              style: kTextMenu,
                            ),
                            Text(
                              'Visualize os extrato dos seus pedidos',
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: Color(0xff38ad53),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdReport(_restaurant)));
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30),),
                        Icon(Icons.attach_money, size: 25, color: Colors.grey),
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Preço médio',
                              style: kTextMenu,
                            ),
                            Text(
                              'Visualize o preço médio dos pratos vendidos',
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

}