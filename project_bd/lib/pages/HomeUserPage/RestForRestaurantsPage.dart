import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bd/Control/Control.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeUserPage/restaurantPage.dart';

class RestForRestaurantsPage extends StatefulWidget {
  Restaurant _restaurants;

  RestForRestaurantsPage(this._restaurants);

  @override
  State<StatefulWidget> createState() =>
      _RestForRestaurantsPageState(this._restaurants);
}

class _RestForRestaurantsPageState extends State<RestForRestaurantsPage> {
  List<Restaurant> _restaurant = new List<Restaurant>();
  Restaurant _restaurants;

  _RestForRestaurantsPageState(this._restaurants);

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    Control control = Control();
    control.getAllRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
          ),
          Container(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff38ad53),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 4.5),
                ),
                Text(
                  '${this._restaurants.name}'.toUpperCase(),
                 style: TextStyle(fontSize: 16, letterSpacing: 1.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Container(
            height: 10,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width - 20,
            child: ListView.builder(
              itemCount: this._restaurant.length,
              itemBuilder: (BuildContext cntx, int index) {
                return RawMaterialButton(
                  onPressed: () => goToRest(this._restaurant[index]),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 80,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 1.0, //ext
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20),
                                bottomLeft: const Radius.circular(20)),
                            child: Image.network(
                              '${this._restaurant[index].url}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 130,
                          margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
                          child: Center(
                            child: Text(
                              '${this._restaurant[index].name}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void goToRest(Restaurant r) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RestaurantPage(r)));
  }
}
