import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';
import 'package:project_bd/pages/HomeUserPage/RestForCategoriesPage.dart';

class HomePageUser extends StatefulWidget {
  List<Categories> _cat;
  User _user;

  HomePageUser(this._user, this._cat);
  @override
  State<StatefulWidget> createState() => _HomePageStateUser( this._user, this._cat);
}

class _HomePageStateUser extends State<HomePageUser> {
  final scaffolKey = GlobalKey<ScaffoldState>();
  User _user;
  int currentIndex;
  _HomePageStateUser( this._user, this._categories);
  List<Categories> _categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: test(),
    );
  }

  Widget test() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: <Widget>[
      Stack(
        children: <Widget>[
          Positioned(
              child: Container(
            child: Image.asset(
              './assets/pizza.jpg',
              fit: BoxFit.fill,
            ),
            height: 170,
            width: MediaQuery.of(context).size.width,
          )),
          Positioned(
            top: 100,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    height: 150,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Entrega',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.start,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          '${this._user.address}',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ],
                    ))),
          ),
        ],
      ),
      Container(
        height: 10, 
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 20, 10, 0),
        color: Colors.grey.shade100,
        
        ),

          // child: allWidgetRest(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Categorias', style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                Padding(padding: EdgeInsets.only(top:10)),

                 getListView()
              ],
            ),
          ),
          Container(
        height: 10, 
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(15, 20, 10, 0),
        color: Colors.grey.shade100,
        
        ),
    ]);
  }

  Widget getListView() {
    if (this._categories == null) {
      return Center(
        child: Text('Sem categorias cadastradas'),
      );
    } else {
      return 
      SizedBox(
    
        width: MediaQuery.of(context).size.width,
        height: 150,
        child:
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this._categories.length,
              itemBuilder: (BuildContext context, int index) {
                return 
                FlatButton(onPressed: (){call(this._categories[index]);}, 
                child: 
                  Column(
                    children: <Widget>[
                        
                        ClipRRect(
                          
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '${this._categories[index].image}',
                            fit: BoxFit.fill,
                            width: 200,
                            height: 126,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:5)),
                        Text('${this._categories[index].name}', style: TextStyle(fontSize:16),),
                       

                    ],
                  ));
              })
         
         ,
         );
    }
  }

  void call(Categories c) async{
    DatabaseHelper db = DatabaseHelper.internal();
    List<Restaurant> rests = await db.getRestByIdCategories(c.id);
    Navigator.push(context, MaterialPageRoute(builder:(context)=> RestForCategoriesPage(rests, c)));
  }
}
