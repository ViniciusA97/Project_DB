import 'package:flutter/material.dart';

class Pratos extends StatefulWidget {
  @override
  _PratosState createState() => _PratosState();
}

class _PratosState extends State<Pratos> {

  Widget item(String nome, int distancia){
    return Container(
      width: 500,
      height: 160,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('Pizza M - Frango com Cheddar'),
            subtitle: Text('25,00 R\$'),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Verificar'),
                onPressed: () { print('$nome');},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pratos", style: TextStyle(color: Colors.white, fontSize: 20.0),), backgroundColor: Colors.pink,),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Container(
         child: Column(
           children: <Widget>[
             Container(
               width: 600,
               height: 750,
               decoration: BoxDecoration(
                   border: Border.all(color: Colors.black)
               ),
               child: Column(
                 children: <Widget>[
                   Padding(
                     padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                     child:
                     Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           Text("Cardápio", style: TextStyle(color: Colors.pink, fontSize: 25.0, fontWeight: FontWeight.bold),),
                         ]
                     ),
                   ),

                   Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),),
                   item("Bar", 15),
                   Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),),
                   item("Bar", 15),
                 ],
               ),
             ),
             Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),),
             ButtonTheme(
               minWidth: 100.0,
               height: 35.0,
               child: RaisedButton(onPressed: ()=> print("Confirmar"),
                 shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                 child: Text("Cadastrar novo prato",
                   style: TextStyle(color: Colors.white, fontSize: 15), ),
                 color: Colors.pink,
               ),
             ),
           ],
         ),
        )
      ),
    );
  }
}
