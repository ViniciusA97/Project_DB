import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/data/database.dart';

import 'HomeRestPage.dart';

class AddPrato extends StatefulWidget{
  int _id;

  AddPrato(this._id);
  @override
  State<StatefulWidget> createState()=> _AddPratoState(_id);

}

class _AddPratoState extends State<AddPrato>{
  int _id;
  String name;
  String img;
  double preco;
  String descricao;
  final formKey = new GlobalKey<FormState>();
  bool loading =false;

  _AddPratoState(this._id);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body(){
    return 
    Container(child:
    Column(children: <Widget>[
      
      Padding(padding: EdgeInsets.only(top:30)),
      Text('Adicionar Prato', style: TextStyle(fontSize: 20),),
        Form(
          key: formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome do prato',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  onSaved:(val)=> name=val ,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Preço',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  onSaved:(val)=> preco=double.parse(val) ,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Url imagem',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  onSaved:(val)=> img=val ,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.white,
                    filled: true
                  ),
                  onSaved:(val)=> descricao=val ,
                ),
                Padding(padding: EdgeInsets.only(top:20)),
                RaisedButton(
                  onPressed:_create,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text('Create'),
                ),
              ],
            ),

          ),
        

    ),
    Container(
      height: MediaQuery.of(context).size.height/2,
      child:
    
                Stack(
                 
                children: <Widget>[
                  Positioned(
                    child:
                    new Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Image.asset('./assets/comida5.jpg'),
                    )
                    
                  )
                  
                  ],

               ))

    ],));

  }

  _create() async{
    final form = formKey.currentState;
      if(form.validate()){
        setState(() {
          form.save();
          loading=true;
        });
      }
    DatabaseHelper db = DatabaseHelper.internal();
    Prato prato = Prato(_id, name, preco, descricao, img);
    int rest = await db.savePrato(prato, _id);
    Restaurant res = await db.getRestById(this._id);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RestPage(res)));
    
      
  }

}