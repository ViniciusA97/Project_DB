import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';

class HomePageUser extends StatefulWidget{
  List<Restaurant> _rest;
  
  HomePageUser(this._rest);
  @override
  State<StatefulWidget> createState() => _HomePageStateUser(_rest);

}
class _HomePageStateUser extends State<HomePageUser>{
 

  final scaffolKey = GlobalKey<ScaffoldState>();
  List<Restaurant> _rests;
 int currentIndex;
  _HomePageStateUser(this._rests);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.red,
      body:  test(),
      
    );

  }

  Widget test(){
    print(_rests);

    return 
    Column(
       
      children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50),),
            Text('Restaurantes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
        
      
    
    SizedBox(
      height : MediaQuery.of(context).size.height-100,
      child: allWidgetRest(),
    
    )]);
    
  }


  Widget allWidgetRest(){
    return ListView.builder(
      itemCount: _rests.length,
      itemBuilder: (BuildContext context, index){

        return 
        Container(
          margin:const EdgeInsets.only(left: 10, right: 10,bottom: 10, top: 0) ,
          child: new Material(
            borderRadius: new BorderRadius.circular(6.0),
            elevation: 2.0,
            child: Container(
              height: 150,

              child: Row(
                children: <Widget>[
                  new Image.network(_rests[index].url,
                    fit: BoxFit.cover,
                    width: 130.0,
                    height: 150.0
                  ),
                  Expanded(
                    child: Container(
                      margin: new EdgeInsets.all(10),
                      child: new Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_rests[index].name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Padding(padding: EdgeInsets.only(top: 5),),
                          Text(_rests[index].descriprion,style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            )
          ),
        );
      },
    );

  }

  Widget getRest() {

    return ListView.builder(
      itemCount: _rests.length,
      itemBuilder: (BuildContext context, index){
        return Card(child: Text(_rests[index].name),);
      },
    );
  }

 
}
