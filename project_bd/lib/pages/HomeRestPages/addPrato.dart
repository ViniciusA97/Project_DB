import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/Preco.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/constants.dart';

import 'HomeRestPage.dart';

class AddPrato extends StatefulWidget {
  int _id;

  AddPrato(this._id);
  @override
  State<StatefulWidget> createState() => _AddPratoState(_id);
}

class _AddPratoState extends State<AddPrato> {
  int _id;
  String name;
  String img;
  double precoValue;
  String descricao;
  final formKey = new GlobalKey<FormState>();
  bool loading = false;

  _AddPratoState(this._id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              // alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 80)),
                  Text(
                    'Adicionar Prato',
                    style: kTextTitle.copyWith(fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: kTextFieldDecoraction.copyWith(
                                hintText: "Nome do prato"),
                            onSaved: (val) => name = val,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: kTextFieldDecoraction.copyWith(
                                hintText: "Preço"),
                            onSaved: (val) => precoValue = double.parse(val),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          TextFormField(
                            decoration: kTextFieldDecoraction.copyWith(
                                hintText: "URL da imagem"),
                            onSaved: (val) => img = val,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          TextFormField(
                            decoration: kTextFieldDecoraction.copyWith(
                                hintText: "Descrição"),
                            onSaved: (val) => descricao = val,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Color(0xff38ad53),
                                onPressed: _create,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Create',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0)),
                              RaisedButton(
                                color: Color(0xff38ad53),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.131,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: new Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Image.asset('./assets/comida5.jpg'),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _create() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        loading = true;
      });
    }
    Preco preco = Preco(precoValue, DateTime.now());
    print(preco.id);
    Prato prato = Prato(_id, name, preco, descricao, img);
    Control control = Control();
    bool response = await control.savePrato(prato);
    if (response) {
      Restaurant res = await control.getRestByIdRest(prato.idRest);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RestPage(res)));
    } else {
      print('algo de errado nao está certo');
    }
  }
}
