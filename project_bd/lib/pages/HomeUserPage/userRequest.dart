import 'package:flutter/material.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/Control/Control.dart';

class Requests extends StatefulWidget {

  User _user;

  Requests(this._user);

  @override
  _RequestsState createState() => _RequestsState(this._user);
}

class _RequestsState extends State<Requests> {

  _RequestsState(this._user);


  User _user;
  List<Pedido> _pedidos;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    Control control = Control.internal();
    await control.getUserPedidos(this._user.id).then((onValue) {
      setState(() {
        this._pedidos = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
          Text(
            'Pedidos',
            style: kTextTitle.copyWith(fontSize: 20.0),
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
            child: requests(),
          ),
        ],
      ),
    );
  }

  Widget requests(){
    if (this._pedidos == null) {
      return (Center(child: Text('Nenhum pedido realizado')));
    } else {
      return ListView.builder(
        reverse: true,
        itemCount: _pedidos.length,
        itemBuilder: (BuildContext cntx, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Numero do Pedido: ${this._pedidos[index].idPedido}'),
                    Text('Preço: ${this._pedidos[index].preco}'),
                  ],
                ),
                Text('Data: ${this._pedidos[index].data}')
              ],
            ),
          );
        },
      );
    }
  }
}