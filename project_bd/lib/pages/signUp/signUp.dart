import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/constants.dart';

import '../../constants.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final scafolldKey = GlobalKey<ScaffoldState>();
  bool isLoading;
  final formKey = GlobalKey<FormState>();
  String email;
  String pass;
  String number;
  String name;
  String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scafolldKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height / 3 * 2,
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        Text(
                          'Create your user account',
                          style: kTextTitle.copyWith(fontSize: 21.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        TextFormField(
                          decoration:
                              kTextFieldDecoraction.copyWith(hintText: 'name'),
                          onSaved: (val) => name = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration:
                              kTextFieldDecoraction.copyWith(hintText: 'email'),
                          onSaved: (val) => email = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'password'),
                          onSaved: (val) => pass = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'number'),
                          onSaved: (val) => number = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'adress'),
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
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                      ],
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Positioned(
                        child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Image.asset('./assets/comida2.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _create() async {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        isLoading = true;
      });
    }
    Control control = Control();
    User temp = User(name, pass, email, address, number);
    print('$name');
    bool confirmate = await control.saveUser(temp);
    if (confirmate) {
      Navigator.pop(context);
    } else {
      _showSnackBar('Erro! Preencha os campos ou troque o email');
    }
  }

  _showSnackBar(String text) {
    final key = scafolldKey.currentState;
    key.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}
