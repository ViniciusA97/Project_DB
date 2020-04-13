import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bd/data/database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:project_bd/pages/HomeRestPages/reportsPage.dart';
import 'package:project_bd/pages/HomeRestPages/secondReport.dart';

class Menu extends StatefulWidget {

  Restaurant _restaurant;

  Menu(this._restaurant);

  @override
  _MenuState createState() => _MenuState(this._restaurant);

}

class _MenuState extends State<Menu> {

  Restaurant _restaurant;
  TimeOfDay _open;
  TimeOfDay _close;

  _MenuState(this._restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body(){
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {delivery(context);},
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                        Icon(FontAwesomeIcons.motorcycle, size: 25, color: Colors.grey,),
                        Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Tipo de entrega',
                              style: kTextMenu,
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              'Escolha o tipo de entrega',
                              textAlign: TextAlign.justify,
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: Color(0xff38ad53),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){chooseTime(context);},
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30),),
                        Icon(FontAwesomeIcons.clock, size: 25, color: Colors.grey),
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Horário',
                              style: kTextMenu,
                            ),
                            Text(
                              'Escolha o horário de funcionamento',
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: Color(0xff38ad53),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsPage(_restaurant)));
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 30),),
                        Icon(FontAwesomeIcons.chartLine, size: 25, color: Colors.grey),
                        Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Relatórios',
                              style: kTextMenu,
                            ),
                            Text(
                              'Visualize seus relatórios',
                              style: kSubTextMenu,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void delivery(context){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                setState(() {
                  this._restaurant.setEntrega(1);
                  saveDeliveryType(1);
                });
                Navigator.pop(context);
              },
              color: Color(0xff38ad53),
              child: Text(
                'Entrega Grátis',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                setState(() {
                  this._restaurant.setEntrega(0);
                  saveDeliveryType(0);
                });
                Navigator.pop(context);
              },
              child: Text(
                'Entrega rápida',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                setState(() {
                  // só para voltar para o ícone anterior
                });
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveDeliveryType(int a) async{
      var db = DatabaseHelper.internal();
      db.updateEntrega(this._restaurant, a);
  }

  void chooseTime(context){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 190,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.pop(context);
                timePicker(false);
                // tp();
              },
              color: Color(0xff38ad53),
              child: Text(
                'Abertura',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                Navigator.pop(context);
                timePicker(true);
                // Navigator.pop(context);
              },
              child: Text(
                'Fechamento',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              color: Color(0xff38ad53),
              onPressed: (){
                setState(() {
                  // só para voltar para o ícone anterior
                });
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void timePicker(bool isClosing){
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
          this._restaurant.setHoraAbre(date);
          saveOpenTime(date);
        }
        else 
        {
          this._restaurant.setHoraFecha(date);
          saveCloseTime(date);
        } 
        print('confirm $date');
      },
      currentTime: DateTime.now(), 
      theme: DatePickerTheme(
        doneStyle: TextStyle(color: Color(0xff38ad53), fontWeight: FontWeight.bold),
      ),
    ); 
  }

  void saveOpenTime(DateTime date) async {
    var db = DatabaseHelper.internal();
    db.saveOpenTime(this._restaurant.id, date);
  }

  void saveCloseTime(DateTime date) async {
    var db = DatabaseHelper.internal();
    db.saveCloseTime(this._restaurant.id, date);
  }
  
}