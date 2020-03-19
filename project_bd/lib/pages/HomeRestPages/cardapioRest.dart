import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/constants.dart';
import 'package:project_bd/pages/HomeRestPages/addPrato.dart';

class CardapioPage extends StatefulWidget {
  
  int _id;

  CardapioPage( this._id);

  @override
  State<StatefulWidget> createState() =>
      _CardapioPageState(this._id);
}

class _CardapioPageState extends State<CardapioPage> {
  List<Prato> _pratos = List<Prato>();
  int _id;

  _CardapioPageState( this._id);

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async{
    Control control = Control.internal();
    await control.getPratosRestaurant(this._id)
      .then((onValue){
        setState(() {
          print('on value : $onValue');
          this._pratos = onValue; 
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrato(_id)));  
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff38ad53),
      ),
      body: Container(
        // margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text(
            'Pratos',
            style: kTextTitle.copyWith(fontSize: 20.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Stack(children: <Widget>[


          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(20))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.8,
            child: cardapio(),
          )
          ],),
        ])));
  }

  Widget cardapio() {
    if (this._pratos == null) {
      return Center(
        child: Text('Sem pratos cadastrados'),
      );
    } else {
      return ListView.builder(
          itemCount: this._pratos.length,
          itemBuilder: (BuildContext cntx, int index) {
            return Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: MediaQuery.of(context).size.width - 30,
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        height: 250,
                        width: MediaQuery.of(context).size.width - 40,
                        child: ClipRRect(
                          child: Image.network(
                            '${this._pratos[index].img}',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        )),
                    Positioned(
                        top: 200,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            color: Color(0xff38ad53),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    
                                    '${this._pratos[index].name}',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text('\$${this._pratos[index].preco.preco}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))

                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top:5)),
                              Text('${this._pratos[index].descricao}', style: TextStyle(color: Colors.white),)
                            ],
                            
                          ),
                        ))
                  ],
                ));
          });
    }
  }

  Widget getListView() {
    if (this._pratos == null) {
      return Center(
        child: Text(
          'Não há pratos cadastrados.',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return null;
    }
  }

  Widget getRow(int dir, int esq) {
    if (dir > this._pratos.length) {
      return Row(
        children: <Widget>[
          getContainer(esq),
          Container(
            width: 200,
            height: 100,
            color: Colors.grey.shade100,
          )
        ],
      );
    }

    return Row(
      children: <Widget>[getContainer(esq), getContainer(dir)],
    );
  }

  Widget getContainer(int index) {
    return Container(
      height: 100,
      width: 200,
      child: Stack(
        children: <Widget>[
          Positioned(child: Image.network(this._pratos[index].img)),
          Positioned(
              child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('${this._pratos[index].name}'),
                          Text('\$${this._pratos[index].preco}'),
                        ],
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}

//      interacao de uma lista com 6 objs
//interação(index = 0)        cont1(0)         cont2(1)
//interação(index = 1)        cont1(2)         cont2(3)
//interação(index = 2)        cont1(4)         cont2(5)

//    interacao de uma lista com 5 objs
//interação(index =0)         cont1(0)         cont2(1)
//interação(index =1)         cont1(2)         cont2(3)
//interação(index =3)         cont1(4)         null
