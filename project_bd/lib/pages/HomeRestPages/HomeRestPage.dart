import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';

class RestPage extends StatefulWidget{
  Restaurant _rest;
  
  RestPage(this._rest);
  @override
  State<StatefulWidget> createState() => _RestPageState(_rest);

}
class _RestPageState extends State<RestPage>{
 

  final scaffolKey = GlobalKey<ScaffoldState>();
  Restaurant _rests;
 
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    print(this._rests);
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.white,
      body:null ,
      bottomNavigationBar: bottomAppBar(context));

  }


  Widget test(){
    print(_rests);

    return 
    Column(
       mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[   
          
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(bottomLeft: const Radius.circular(20), bottomRight: const Radius.circular(20),topLeft: const Radius.circular(20),topRight: const Radius.circular(20))
            ),
            width: MediaQuery.of(context).size.width,
            child: Image.network(_rests.url),
          ),
        
        Padding(padding: EdgeInsets.only(top: 15),),
      
           Container(
            width: MediaQuery.of(context).size.width-30,
            child: Text('${this._rests.name}', style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
            color: Colors.white,
        
          ),
        
    
    ]);
    
  } 

  Widget bottomAppBar(context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: IconCall(
            icone: Icons.list,
            nome: "Home",
            tamanho: 60.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => homeRest());
            },
          )),
          Expanded(
            child: IconCall(
              icone: Icons.content_paste,
              nome: "Cardapio",
              tamanho: 60,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            cardapioRest()));
              },
            ),
          ),
          Expanded(
            child: IconCall(
              icone: Icons.comment,
              nome: "Pedidos",
              tamanho: 60,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => pedidosRest,
                    ),
                  );
                },
            ),
          )
        ],
      ),
    );
  }


}

class IconCall extends StatelessWidget {
  final String nome;
  final IconData icone;
  final double tamanho;
  final VoidCallback onPressed;

  IconCall.small({this.nome, this.icone, this.onPressed}) : this.tamanho = 60.0;

  IconCall({this.nome, this.icone, this.onPressed, this.tamanho});

  Widget build(BuildContext context) {
    return Container(
      width: tamanho + 10,
      height: tamanho + 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RawMaterialButton(
            onPressed: onPressed,
            child: Icon(icone),
          ),
          Text(nome),
        ],
      ),
    );
  }
}

