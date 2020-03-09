import 'package:project_bd/constants.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/pages/login/loginPage.dart';
import 'package:project_bd/pages/signUp/SignUpRest.dart';
import 'package:project_bd/pages/signUp/signUp.dart';

class UserForm extends StatelessWidget {

  UserForm({this.email, this.password, this.submitRest, this.submitUser, @required this.isRest});
  String email;
  String password;
  final Function submitRest;
  final Function submitUser;
  bool isRest;
  String userType;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            scrollPadding: const EdgeInsets.all(200.0),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: kTextFieldDecoraction.copyWith(hintText: 'email'),
            onSaved: (value) => email = value,
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration:
                kTextFieldDecoraction.copyWith(hintText: 'password'),
            onSaved: (value) => password = value,
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          RaisedButton(
            color: Color(0xff38ad53),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            onPressed: isRest ? submitUser : submitRest,
            child: Text('submit', style: TextStyle(color: Colors.white),),
          ),
          FlatButton(
            child: Text('Don\'t have a ${isRest ? 'user' : 'restaurant'} account?',
              style: TextStyle(color: Colors.black54)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => isRest ? SignUp() : SignUpRest()));
            },
          )
        ],
      ),
    );
  }
}

