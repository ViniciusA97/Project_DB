import 'package:flutter/material.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:intl/intl.dart';

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
    Control control = Control();
    await control.getUserPedidos(this._user.id).then((onValue) {
      setState(() {
        print(onValue);
        this._pedidos = onValue;
      });
    });
  }

  void sortPedidos(){
    this._pedidos.sort();
  }

  Widget setupAlertDialoadContainer(Pedido p) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Column(
        children: <Widget>[
          Container(
            height: 250.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: p.prato.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${p.qnt[index]}x  ${p.prato[index].name}'),
                  subtitle: Text("R\$ ${(p.prato[index].preco.preco).toStringAsFixed(2)}"),
                );
              },
            ),
          ),
          MaterialButton(
            height: 20,
            minWidth: 100,
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Voltar', style: TextStyle(fontSize: 16, color: Colors.green),
          ),)

        ],
      ),
    );
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
        itemCount: _pedidos.length,
        itemBuilder: (BuildContext cntx, int index) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 230,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Icon(Icons.check_circle_outline, color: Color(0xff38ad53),),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('${this._pedidos[index].rest.name}', style: TextStyle(fontSize: 20, color: Colors.black,  fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('${DateFormat('dd/MM/yyyy - kk:mm').format(this._pedidos[index].data)}', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Pedido nº ${this._pedidos[index].idPedido}', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:10),),
                    Divider(color: Colors.grey),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Text('Entregue em: ${this._pedidos[index].adress}', style: TextStyle(fontSize: 12, color: Colors.grey,)),                    
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Total R\$ ${(this._pedidos[index].preco).toStringAsFixed(2)}', style: TextStyle(fontSize: 15, color: Colors.black,)),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Center(
                      child: MaterialButton(
                        height: 20,
                        minWidth: 100,
                        onPressed: (){
                          print(this._pedidos[index].prato);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('ITENS', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                                content: setupAlertDialoadContainer(this._pedidos[index]),
                            );
                            }
                          );
                        },
                        child: Text('Ver recibo', style: TextStyle(fontSize: 13, color: Color(0xff38ad53)),),
                      ),
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom:20),),
            ],
          );
        },
      );
    }
  }
}