import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/components/Search.dart';
import 'package:project_bd/pages/HomeUserPage/RestForCategoriesPage.dart';
import 'package:project_bd/pages/HomeUserPage/RestForRestaurantsPage.dart';
import 'package:project_bd/pages/HomeUserPage/RestaurantsList.dart';

class HomePageUser extends StatefulWidget {
  User _user;

  HomePageUser(this._user);
  @override
  State<StatefulWidget> createState() => HomePageStateUser(this._user);
}

class HomePageStateUser extends State<HomePageUser> {

  bool _isSearch = false;
  final scaffolKey = GlobalKey<ScaffoldState>();
  User _user;
  int currentIndex;
  int currentIndexRest;
  final myController = TextEditingController();
  HomePageStateUser(this._user);
  List<Categories> _categories;
  List<Restaurant> _restaurants;
  String appBarTitle = "Busque por um prato ou restaurante.";
  Icon actionIcon = new Icon(Icons.search);
  bool habilitarBusca = false;

  @override
  void initState() {
    super.initState();
    _ayncInitMethod();
  }

  _ayncInitMethod() async {
    Control control = Control.internal();
    await control.getAllCategories().then((value) {
      setState(() {
        this._categories = value;
        print(value);
      });
    });
    this._restaurants = await control.getAllRestaurants();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffolKey,
      backgroundColor: Colors.white,
      body: _isSearch? setSearch(): test(),
    );
  }


  Widget setSearch(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Search(this),
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
                              'Bem-vindo ${this._user.name}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey.shade700),
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade100
            ),
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, 0, MediaQuery.of(context).size.width*0.02, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 0,0),
            width: MediaQuery.of(context).size.width*0.95,
            height: 40,
            alignment: Alignment.center,
            child: MaterialButton(
              onPressed: (){
                setState(() {
                  this._isSearch=true;
                });
                },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Buscar '),
                    Icon(Icons.search),
                  ],
                ),
              ),
              ),
          
          ),
          Padding(padding: EdgeInsets.only(top:10)),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Categorias',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
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
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this._categories.length,
            itemBuilder: (BuildContext context, int index) {
              return FlatButton(
                  onPressed: () {
                    call(this._categories[index]);
                  },
                  child: Column(
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
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Text(
                        '${this._categories[index].name}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ));
            }),
      );
    }
  }

  void call(Categories c) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RestForCategoriesPage(c)));
  }

  void setSearchFalse(){
    setState(() {
      _isSearch = false;
    });
  }
}
