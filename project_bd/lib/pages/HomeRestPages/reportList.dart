import 'package:flutter/material.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/restaurant.dart';

class ReportList extends StatefulWidget {

  Restaurant _restaurant;
  ReportList(this._restaurant);
  @override
  _ReportListState createState() => _ReportListState(this._restaurant);
}

class _ReportListState extends State<ReportList> {

  Restaurant _restaurant;
  _ReportListState(this._restaurant);
  List<Pedido> _pedidos = List<Pedido>(); 

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _restaurant.numPedidos, 
      itemBuilder: (BuildContext cntx, int index){
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // TODO: Adicionar os detalhes do pedido
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}