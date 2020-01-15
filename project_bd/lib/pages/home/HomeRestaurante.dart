import 'package:flutter/material.dart';

class HomeRestaurante extends StatefulWidget {
  @override
  _HomeRestauranteState createState() => _HomeRestauranteState();
}

class _HomeRestauranteState extends State<HomeRestaurante> {
  String nomeRest = "Tropical Bar";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),),
          Text("Bem-vindo(a) "+nomeRest, style: TextStyle(color: Colors.pink, fontSize: 30.0, fontWeight: FontWeight.bold),),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Cadastrar prato", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),),
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Pedidos", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Histórico de pedidos", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),),
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Estatísticas", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Dados do restaurante", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),),
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: Text("Promoções", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Configurações", style: TextStyle(color: Colors.pink, fontSize: 20.0, fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),),
                    ButtonTheme(
                      minWidth: 40.0,
                      height: 40.0,
                      child: RaisedButton(onPressed: ()=> print("Confirmar"),
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                        child: Text("",
                          style: TextStyle(color: Colors.white, fontSize: 15), ),
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Logout", style: TextStyle(color: Colors.pink, fontSize: 20.0, fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),),
                    ButtonTheme(
                      minWidth: 40.0,
                      height: 40.0,
                      child: RaisedButton(onPressed: ()=> print("Confirmar"),
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                        child: Text("",
                          style: TextStyle(color: Colors.white, fontSize: 15), ),
                        color: Colors.pink,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      color: Colors.white,
    );
  }
}
