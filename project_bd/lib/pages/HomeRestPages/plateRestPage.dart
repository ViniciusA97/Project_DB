import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/Preco.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/constants.dart';
import 'HomeRestPage.dart';
import 'package:project_bd/Model/restaurant.dart';

class RestPlate extends StatefulWidget {
  final Prato _prato;

  RestPlate(this._prato);

  @override
  _RestPlateState createState() => _RestPlateState(this._prato);
}

class _RestPlateState extends State<RestPlate> {

  final Prato _prato;
  _RestPlateState(this._prato);
  double precoV;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: page());
  }

  Widget page() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      right: MediaQuery.of(context).size.width / 9,
                    ),
                  ),
                  Text(
                    'Detalhes do item',
                    style: TextStyle(fontSize: 16, letterSpacing: 1.0),
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
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network(
                      '${this._prato.img}',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                  ),
                  Text(
                    '${this._prato.name}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text('${this._prato.descricao}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    '\$${this._prato.preco.preco}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RawMaterialButton(
                        child: Text(
                          'Mude o preço',
                          style: TextStyle(color: Colors.white),
                        ),
                        elevation: 6.0,
                        constraints:
                            BoxConstraints.tightFor(width: 130.0, height: 50.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fillColor: Color(0xff38ad53),
                        onPressed: () {
                          setState(() {
                            chagePrice(context);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void chagePrice(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.only(left: 50.0, right: 50.0),
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration:
                    kTextFieldDecoraction.copyWith(hintText: "Novo preço"),
                onSaved: (val) => precoV = double.parse(val),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xff38ad53),
                  onPressed: () {
                    setState(() {
                      _updatePrice();
                      this._prato.preco.preco;
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                RaisedButton(
                  color: Color(0xff38ad53),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updatePrice() async{
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });
    }
    print(precoV);
    Preco p = Preco(precoV, DateTime.now());
    _prato.setPreco(p);
    Control control = Control.internal();
    await control.updatePreco(_prato);
  }
}
