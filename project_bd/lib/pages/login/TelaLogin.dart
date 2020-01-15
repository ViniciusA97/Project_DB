import 'package:flutter/material.dart';
class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Stack(
          children: <Widget>[
            Image.asset(
              "images/home.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(100.0, 370.0, 100.0, 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuário ou identificador",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  ),
                  TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Senha",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  ),
                  Text("Esqueceu a senha?",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  ),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 35.0,
                    child: RaisedButton(onPressed: ()=> print("Entrar"),
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                    child: Text("ENTRAR",
                    style: TextStyle(color: Colors.white, fontSize: 15), ),
                    color: Colors.pink
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                  ),
                  Text("Caso não tenha se registrado:",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  ),
                  ButtonTheme(
                    minWidth: 140.0,
                    height: 35.0,
                    child: RaisedButton(onPressed: ()=> print("Cadastrar"),
                        color: Colors.pink,
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                        child: Text("Cadastre-se",
                          style: TextStyle(color: Colors.white, fontSize: 15), ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
