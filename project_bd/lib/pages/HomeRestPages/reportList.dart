import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/restaurant.dart';

class ReportList extends StatefulWidget {

  Restaurant _restaurant;
  int days;
  ReportList(this._restaurant, @required this.days);
  @override
  _ReportListState createState() => _ReportListState(this._restaurant, this.days);
}

class _ReportListState extends State<ReportList> {

  Restaurant _restaurant;
  int days;
  double preco;
  _ReportListState(this._restaurant, this.days);
  List<Pedido> _pedidos = List<Pedido>(); 


  @override
  void initState() {
    
    _asyncMethod();
    super.initState();
  }

  void _asyncMethod() async {
    Control control = Control();
    if(this.days == 1)
    {
      await control.getRelatorio1day(this._restaurant.id).then((onValue) {
        setState(() {
          this._pedidos = onValue;
          print(this._pedidos.length);
          print(this._pedidos[0].prato.length);
        });
      });
      
    }
    else if(this.days == 7)
    {
      await control.getRelatorio7day(this._restaurant.id).then((onValue) {
        setState(() {
          this._pedidos = onValue;
          print(this._pedidos);
        });
      });
    }
    else if(this.days == 30)
    {
      await control.getRelatorio30day(this._restaurant.id).then((onValue) {
        setState(() {
          this._pedidos = onValue;
          print(this._pedidos[0].prato[0].name);
        });
      });
    }

  }

  Widget setupAlertDialoadContainer(Pedido p) {

    print(p.prato[0].preco.preco);


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
                  title: Text(p.prato[index].name),
                  subtitle: Text("R\$ ${p.prato[index].preco.preco}0"),
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

    if(this._pedidos == null) {
      return Center(
        child: Text('Nenhum pedido realizado'),
      );
    }
    else{
      return ListView.builder(
        itemCount: this._pedidos.length, 
        itemBuilder: (BuildContext cntx, int index){
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Pedido nº ${this._pedidos[index].idPedido}', style: TextStyle(fontSize: 20, color: Colors.black,  fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('${DateFormat('dd/MM/yyyy - kk:mm').format(this._pedidos[index].data)}', style: TextStyle(fontSize: 15, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Divider(color: Colors.grey),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Text('Total R\$ ${this._pedidos[index].preco}0', style: TextStyle(fontSize: 15, color: Colors.black,)),
                    Padding(padding: EdgeInsets.only(bottom:5),),
                    Text('Restaurante: R\$ ${this._pedidos[index].preco - 2}0', style: TextStyle(fontSize: 14, color: Colors.grey,)),
                    Text('Frete: R\$ 2.00', style: TextStyle(fontSize: 14, color: Colors.grey,)),
                    Padding(padding: EdgeInsets.only(bottom:7),),
                    Center(
                      child: MaterialButton(
                        height: 10,
                        minWidth: 100,
                        onPressed: () {
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
                        child: Text('Ver itens do pedido', style: TextStyle(fontSize: 13, color: Color(0xff38ad53))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      );
    }
  }
}