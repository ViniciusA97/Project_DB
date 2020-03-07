import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';

import '../../Model/pedidos.dart';
import '../../Model/restaurant.dart';
import '../../Model/restaurant.dart';
import '../../data/database.dart';
import '../../data/database.dart';

class PedidosRest extends StatefulWidget{

  Restaurant _rest;

  PedidosRest(this._rest);

  @override
  State<StatefulWidget> createState() => _PedidosRestState(this._rest);

}

class _PedidosRestState extends State<PedidosRest>{

  _PedidosRestState(this._rest);

  Restaurant _rest;
  List<Pedido> _pedidos;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod()async{
    Control control = Control.internal();
    await control.getRestPedidos(this._rest.id)
      .then((onValue){
        setState(() {
          this._pedidos=onValue;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }
  

  Widget body(){
    return 
    Container(
      alignment: Alignment.center,
      child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top:30)),
        Text('Pedidos', style: TextStyle(fontSize: 20,color: Colors.black),),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          width: MediaQuery.of(context).size.width-40,
          height: MediaQuery.of(context).size.height-150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200
          ),
          child: pedidos(),
          
        )
      ],
    ));
  }

  Widget pedidos(){
    if(this._pedidos==null){
      return(
        Center(child: 
          Text('Nenhum pedido cadastrado')
        )
        );
    }else{
      return 
      ListView.builder(
        itemCount: _pedidos.length,
        itemBuilder:(BuildContext cntx , int index){
          return
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Numero do Pedido: ${this._pedidos[index].idPedido}'),
                      Text('Preço: ${this._pedidos[index].prato.preco}'),
                    ],
                  ),
                  Text('Cliente: ${this._pedidos[index].user.name}'),
                  Text('Data: ${this._pedidos[index].data}')
                ],
              ),

          );
        } 
      );
    }
  }

}