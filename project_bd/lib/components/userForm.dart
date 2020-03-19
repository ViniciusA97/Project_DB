import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/constants.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/pages/HomeRestPages/HomeRestPage.dart';
import 'package:project_bd/pages/HomeUserPage/HomeUserPage.dart';
import 'package:project_bd/pages/signUp/SignUpRest.dart';
import 'package:project_bd/pages/signUp/signUp.dart';

class UserForm extends StatefulWidget {
 
  UserForm(
      {@required this.isRest});
 
  bool isRest;
  String userType;

  @override
  State<StatefulWidget> createState() =>
      _UserFormState(isRest);
}

class _UserFormState extends State<UserForm> {
  _UserFormState( this.isRest);

  String _email;
  final key = GlobalKey<FormState>();
  String _password;
  bool isRest;
  String userType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
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
            onSaved: (value) => _email = value,
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          TextFormField(
            onTap: (){
              print('vai dar certo');
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: kTextFieldDecoraction.copyWith(hintText: 'password'),
            onSaved: (value) => _password = value,
          ),
          Padding(
            padding: EdgeInsets.all(5),
          ),
          RaisedButton(
            color: Color(0xff38ad53),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            onPressed: () {
              isRest ? _submitRest() : _submitUser();
            },
            child: Text(
              'submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            child: Text(
                'Don\'t have a ${isRest ? 'restaurant' : 'user'} account?',
                style: TextStyle(color: Colors.black54)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => isRest ? SignUpRest() : SignUp()));
            },
          )
        ],
      ),
    );
  }

  void _submitUser() async {
    print('submitUser');
    final form = key.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });
    }
    var control = Control.internal();
    var user = await control.doLogin(_email, _password);
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePageUser(user)));
    } else {
      //_showSnackBar('User dont exist');
    }
  }

  void _submitRest() async {
    print('SubmitRest');
    final form = key.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
      });
    } else {
      return;
    }
    print('email: '+_email);
    var control = Control.internal();
    Restaurant rest = await control.doLoginRestaurant(_email, _password);
    if (rest != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RestPage(rest)));
    } else {
      //_showSnackBar('Restaurant dont exist');
    }
  }
}
