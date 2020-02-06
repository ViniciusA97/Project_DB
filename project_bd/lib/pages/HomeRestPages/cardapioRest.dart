import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/pages/HomeRestPages/addPrato.dart';

class CardapioPage extends StatefulWidget {
  List<Prato> _pratos;
  int _id;

  CardapioPage(this._pratos, this._id);

  @override
  State<StatefulWidget> createState() =>
      _CardapioPageState(this._pratos, this._id);
}

class _CardapioPageState extends State<CardapioPage> {
  List<Prato> _pratos;
  int _id;
  int rep;

  _CardapioPageState(this._pratos, this._id);

  @override
  void initState() {
    rep = (this._pratos.length / 2).round();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrato(_id)));
            
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green.shade100,
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Text(
                'Pratos',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height - 160,
                child: cardapio(),
              )
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
                padding: EdgeInsets.only(left: 10),
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
                          height: 50,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                '${this._pratos[index].name}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text('\$${this._pratos[index].preco}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))
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
