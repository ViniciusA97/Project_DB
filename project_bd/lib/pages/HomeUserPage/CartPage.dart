import 'package:flutter/material.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartPage extends StatefulWidget {
  List<Prato> _pratos = List<Prato>();
  List<int> _quant = List<int>();

  //BagPage(this._pratos, this._quant);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<Prato> _pratos = List<Prato>();
  List<int> _quant = List<int>();
  Control control = Control.internal();

  //_BagPageState(this._pratos, this._quant);

  void initState() {
    super.initState();
    _ayncInitMethod();
  }
  _ayncInitMethod() async {
    await control.getCart().then((value) {
      setState(() {
        this._pratos = value.keys.toList();
        this._quant = value.values.toList();
      });
    });
    print("Pratos novos");
    print(_pratos);
    print("Pratos novos");
  }

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
                      right: MediaQuery.of(context).size.width / 6,),
                ),
                Text(
                  'CARRINHO',
                  style: TextStyle(fontSize: 17, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          getListViewItens(),
        ],
      ),
    );
  }

   Widget getListViewItens() {
    if (this._pratos.isEmpty || this._quant.isEmpty){
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
            padding: EdgeInsets.only(left:10, right: 10),
            height: MediaQuery.of(context).size.height-380,
            child: SizedBox(
            width: MediaQuery.of(context).size.width,
            //height: 150,
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.grey),
              itemCount: this._pratos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                     // alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left:10, top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Color(0xff38ad53),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${this._quant[index]}x   ${this._pratos[index].name}',style: TextStyle(fontSize: 17, color: Colors.black)),
                            Text('Preço un. R\$ ${this._pratos[index].preco.preco}0',style: TextStyle(fontSize: 12, color: Colors.grey))
                          ],),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                            children: <Widget>[
                              Text('R\$ ${this._pratos[index].preco.preco*this._quant[index]}0',style: TextStyle(fontSize: 20, color: Colors.black),),        
                              Padding(padding: EdgeInsets.only(left: 15),),
                              GestureDetector(
                                onTap: (){
                                  control.removeItemCart(this._pratos[index], this._quant[index]);
                                  
                                  //Colocar código pra atualizar página, pensar em outro depois
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage())); 
                                },
                                child: Icon(Icons.delete_sweep, color: Color(0xff38ad53),),
                              ),
                            ]                    
                          ),
                          )
                        ],
                      ),
                    );
                }
              )    
            ),
          ),

          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Adicionar mais itens', style: TextStyle(fontSize: 13, color: Color(0xff38ad53)),),
          ),
          Container(
            height: 7,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget> [
                Padding(padding: EdgeInsets.only(left: 50),),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text("Subtotal", textAlign: TextAlign.start, style: TextStyle(fontSize: 15, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("Entrega", textAlign: TextAlign.start,style: TextStyle(fontSize: 15, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("Total", textAlign: TextAlign.start, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 30, right: 30),),
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: <Widget>[
                      Text("R\$${calculatePreco()}0", textAlign: TextAlign.end, style: TextStyle(fontSize: 15, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("R\$ 2.00", textAlign: TextAlign.end, style: TextStyle(fontSize: 15, color: Colors.grey),),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text("R\$${calculatePreco() + 2}0", textAlign: TextAlign.end, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50),),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 25),),
              Material(
                elevation: 5.0,
                color: Color(0xff38ad53),
                child: MaterialButton(
                  height: 40,
                minWidth: MediaQuery.of(context).size.width-120,
                //MANDAR PROS PEDIDOS AQUI
                onPressed: () async{
                  control.clearCart();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Finalizar compra', style: TextStyle(fontSize: 16, color: Colors.white),),
                ),
              ),
           FlatButton(
            onPressed: (){
              control.clearCart();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Limpar carrinho', style: TextStyle(fontSize: 12, color: Color(0xff38ad53)),),
          ),
        ],
       )
      );
    }
  }
}