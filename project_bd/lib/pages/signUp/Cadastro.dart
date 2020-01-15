import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  int grupo = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(80.0, 40.0, 80.0, 0.0),
            child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 100.0,
                  height: 35.0,
                  child: RaisedButton(onPressed: ()=> print("Confirmar"),
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide.none),
                      child: Text("Voltar",
                        style: TextStyle(color: Colors.pink, fontSize: 15), ),
                      color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          Padding(
          padding: EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 20.0),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),),
                Text("Informe seus dados pessoais: ", style: TextStyle(color: Colors.pink, fontSize: 30.0, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nome completo",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuário ou identificador",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Endereço de e-mail",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  width: 240.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  width: 240.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar senha",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),),
                Text("Identifique-se como: ", style: TextStyle(color: Colors.pink, fontSize: 20.0, fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: grupo,
                      onChanged: (T)=> print("Botão 1"),
                    ),
                    Text("Usuário", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
                    Radio(
                      value: 0,
                      groupValue: grupo,
                      onChanged: (T)=> print("Botão 1"),
                    ),
                    Text("Restaurante", style: TextStyle(color: Colors.pink, fontSize: 15.0, fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                Container(
                  height: 45.0,
                  width: 240.0,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Categoria",
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),),
                ButtonTheme(
                  minWidth: 100.0,
                  height: 35.0,
                  child: RaisedButton(onPressed: ()=> print("Confirmar"),
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                      child: Text("Confirmar",
                        style: TextStyle(color: Colors.white, fontSize: 15), ),
                      color: Colors.pink
                  ),
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}
