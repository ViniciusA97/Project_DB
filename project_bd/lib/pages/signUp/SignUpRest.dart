import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/restaurant.dart';

import '../../constants.dart';

class SignUpRest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpRestState();
}

class _SignUpRestState extends State<SignUpRest> {
  bool isLoading;
  final scafolldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String pass;
  String name;
  String image;
  String description;
  String nume;
  String email;
  String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scafolldKey,
      body: Center(
        child: Column(
          children: <Widget>[
            new Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height / 4 * 3,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                    ),
                    Text(
                      'Create your restaurant account',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontFamily: 'Source Sans Pro',
                        letterSpacing: 2.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'name'),
                      onSaved: (val) => name = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'password'),
                      onSaved: (val) => pass = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'image'),
                      onSaved: (val) => image = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration: kTextFieldDecoraction.copyWith(
                          hintText: 'description'),
                      onSaved: (val) => description = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'email'),
                      onSaved: (val) => email = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'number'),
                      onSaved: (val) => nume = val,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      decoration:
                          kTextFieldDecoraction.copyWith(hintText: 'address'),
                      onSaved: (val) => address = val,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    RaisedButton(
                      color: Color(0xff38ad53),
                      onPressed: _create,
                      child: Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Image.asset('./assets/comida3.jpg'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _create() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        isLoading = true;
      });
    }
    Control control = Control.internal();
    Restaurant temp = Restaurant(
        name, pass, null, 0, image, description, nume, email, address);
    bool condiction = await control.saveRest(temp);
    if (condiction) {
      Navigator.pop(context);
    } else {
      _showSnackBar('Email ou nome ja utilizados.');
    }
  }

  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}
