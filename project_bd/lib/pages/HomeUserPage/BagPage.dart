import 'package:flutter/material.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BagPage extends StatefulWidget {
  List<Prato> _pratos;
  List<int> _quant;

  BagPage(this._pratos, this._quant);

  @override
  _BagPageState createState() => _BagPageState(this._pratos, this._quant);
}

class _BagPageState extends State<BagPage> {

  List<Prato> _pratos;
  List<int> _quant;

  _BagPageState(this._pratos, this._quant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget> [
          page(),
        ],
      ),
    );
  }

  double calculatePreco(){
    double value = 0;
    for(int i = 0; i < this._pratos.length; i++){
      value += this._pratos[i].preco.preco * this._quant[i];
    }
    return value;
  }

  Widget page()
  {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff38ad53),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 9,),
                ),
                Text(
                  'CARRINHO',
                  style: TextStyle(fontSize: 20, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          getListViewItens(),
        ],
      ),
    );
  }

   Widget getListViewItens() {
    if (this._pratos.isEmpty) {
      return Container(
        padding: EdgeInsets.only(top: 30),
        child: Center(
        child: Text('Sem itens no carrinho.', style: TextStyle(fontSize: 16),),
      ),
      );
    } 
    else {
      return Container(
        child: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height-470,
            child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: ListView.builder(
              itemCount: this._pratos.length,
              itemBuilder: (BuildContext context, int index) {
                return MaterialButton(
                  height: 120,
                  minWidth:MediaQuery.of(context).size.width*0.95 ,
                  onPressed: null,
                  child: Container(
                    alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left:10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff38ad53),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(15, 15, 10, 0),
                          child: Text('${this._quant[index]}x   ${this._pratos[index].name}',style: TextStyle(fontSize: 20, color: Colors.white))),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.fromLTRB(15, 10, 20, 0),
                            child: Text('R\$ ${this._pratos[index].preco.preco}0',style: TextStyle(fontSize: 20, color: Colors.white),),                            
                          )
                        ],
                      ),
                    )
                    );
                }
              )    
            ),
          ),

          FlatButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Adicionar mais itens', style: TextStyle(fontSize: 18, color: Color(0xff38ad53)),),
          ),
          Padding(padding: EdgeInsets.only(bottom:20),),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget> [
                Container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text("Subtotal", textAlign: TextAlign.start, style: TextStyle(fontSize: 20, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("Entrega", textAlign: TextAlign.start,style: TextStyle(fontSize: 20, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("Total", textAlign: TextAlign.start, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: <Widget>[
                      Text("R\$${calculatePreco()}0", textAlign: TextAlign.end, style: TextStyle(fontSize: 20, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("R\$ 2,00", textAlign: TextAlign.end, style: TextStyle(fontSize: 20, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("R\$${calculatePreco() + 2}0", textAlign: TextAlign.end, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 40),),
              Material(
                elevation: 5.0,
                color: Color(0xff38ad53),
                child: MaterialButton(
                  height: 60,
                minWidth: MediaQuery.of(context).size.width-120,
                //MANDAR PROS PEDIDOS AQUI
                onPressed: null,
                child: Text('Finalizar compra', style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              )
 
        ],
       )
      );
    }
  }
}