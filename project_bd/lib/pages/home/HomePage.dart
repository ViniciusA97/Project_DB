import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  List<Map> _rest;
  
  HomePage(this._rest);
  @override
  State<StatefulWidget> createState() => _HomePageState(_rest);

}
class _HomePageState extends State<HomePage>{
 

  final scaffolKey = GlobalKey<ScaffoldState>();
  List<Map> _rests;
 
  _HomePageState(this._rests);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(title: Text("Restaurantes"),),
      body:  test(),
    );

  }

  Widget test(){
    print(_rests);
    return ListView.builder(
      itemCount: _rests.length,
      itemBuilder: (BuildContext context, index){
        return Material(
          borderRadius: new BorderRadius.circular(6.0),
          elevation: 2.0,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Adicionamos aqui FadeInImage que é uma variande do widget Image. Ela nos possibilita carregar image de uma URL
              new Image.network(
                 _rests[index]['image'],
                fit: BoxFit.cover,
                width: 95.0,
                height: 95.0
              ),
              new Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_rests[index]['name']),
                ] ,
              )
            ],
          ),
        );
      },
    );
  }

  Widget getRest() {

    return ListView.builder(
      itemCount: _rests.length,
      itemBuilder: (BuildContext context, index){
        return Card(child: Text(_rests[index]['name']),);
      },
    );
  }
}