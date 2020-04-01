import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  int tipoEntrega;
  DateTime hrAbre;
  DateTime hrFecha;
  String buttonNameA = 'Horario de Abertura';
  String buttonNameB = 'Horario de Fechamento';
  int type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scafolldKey,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[
              new Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 60),
                        ),
                        Text(
                          'Create your restaurant account',
                          style: kTextTitle.copyWith(fontSize: 19.0),
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
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'password'),
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
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'number'),
                          onSaved: (val) => nume = val,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        TextFormField(
                          decoration: kTextFieldDecoraction.copyWith(
                              hintText: 'address'),
                          onSaved: (val) => address = val,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('Entrega gratis'),
                            Radio(
                                value: 1,
                                activeColor: Color(0xff38ad53),
                                groupValue: tipoEntrega,
                                onChanged: (int i) {
                                  setState(() {
                                    tipoEntrega = i;
                                  });
                                  print(tipoEntrega);
                                }),
                            Text('Entrega rápida'),
                            Radio(
                                value: 0,
                                activeColor: Color(0xff38ad53),
                                groupValue: tipoEntrega,
                                onChanged: (int i) {
                                  setState(() {
                                    tipoEntrega = i;
                                  });
                                }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: (){
                                timePicker(true,1);
                                // tp();
                              },
                              color: Color(0xff38ad53),
                              child: Text(
                                '$buttonNameA',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            RaisedButton(
                              color: Color(0xff38ad53),
                              onPressed: (){
                                timePicker(true,0);
                                // Navigator.pop(context);
                              },
                              child: Text(
                                '$buttonNameB',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Stack(
                children: <Widget>[
                  Positioned(
                    child: new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Image.asset('./assets/comida3.jpg'),
                    ),
                  )
                ],
              ),
            ]),
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
    Control control = Control();
    Restaurant temp = Restaurant(
        name, pass, image, description, nume, email, address,tipoEntrega,hrAbre,hrFecha);
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

    void timePicker(bool isClosing, int t){
    DatePicker.showTimePicker(
      context, 
      showTitleActions: true,
      onChanged: (date) {
        print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
      },
      onConfirm: (date) {  
        if(!isClosing)
        {
          if(t==1){
            setState(() {
              hrAbre = date;
              buttonNameA ="Abertura: "+ date.toString().substring(10,16);
            }); 
          }
          else{
            setState(() {
              hrFecha = date;
              buttonNameB= "Fechamento: "+date.toString().substring(10,16);
            });
          }
        }
        else 
        {
          if(t==1){
            setState(() {
              hrAbre = date;
              buttonNameA = "Abertura "+date.toString().substring(10,16);
            }); 
          }
          else{
            setState(() {
              hrFecha = date;
              buttonNameB="Fechamento "+ date.toString().substring(10,16);
            });
          }
        } 
        print('confirm $date');
        
      },
      currentTime: DateTime.now(), 
      theme: DatePickerTheme(
        doneStyle: TextStyle(color: Color(0xff38ad53), fontWeight: FontWeight.bold),
      ),
    ); 
  }

}
