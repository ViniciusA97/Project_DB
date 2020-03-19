import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Control/Control.dart';
import '../Model/restaurant.dart';
import '../Model/restaurant.dart';
import '../Model/restaurant.dart';
import '../pages/HomeUserPage/HomeUserPage.dart';

class Search extends StatefulWidget {
  
  HomePageStateUser _home;

  Search(this._home);
  @override
  State<StatefulWidget> createState() => _SearchState(this._home);
}

class _SearchState extends State<Search> {
  _SearchState(this._home);

  final key = GlobalKey<FormState>();
  HomePageStateUser _home;
  String text = '';
  List<Restaurant> _list = new List<Restaurant>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    Form(
                        child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        onChanged: (value){
                          onChangeSearch(value);
                        },
                        onFieldSubmitted: (term){
                          search();
                        },
                        key: key,
                        decoration: InputDecoration(
                          hintText: 'Prato ou restaurant',
                          icon: Icon(Icons.search),
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    this._home.setSearchFalse();
                    
                  },
                  child: Text(
                    "Cancel",
                  ))
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.85,
            child: 

          ListView.builder(
            itemCount: this._list.length,
            itemBuilder: (BuildContext context, int index) {
              if(this._list.isEmpty){
                return Center(
                  child: text=='' ?Text(''): Text('Não foi encontrado nenhum restaurante.') ,
                );
              }else{
                return Container(
                  padding: EdgeInsets.only(left:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(0, 196,0, 1),
                  ),
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02, 0,MediaQuery.of(context).size.width*0.02,0),
                  
                  height: 120,
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network('${this._list[index].url}',height: 100,
                      ),),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                        child: Column(
                          children: <Widget>[
                            Text('${this._list[index].name}',style: TextStyle(fontSize: 20, color: Colors.white),),
                            Padding(padding: EdgeInsets.only(top:10)),
                            Text('${this._list[index].descriprion}',style: TextStyle(color:Colors.white),),
                            
                          ],
                        ) ,
                      )
                    ],
                  ),
                );
              }
            },
            
          )
          )
        ],
      ),
    );
  }

  void search(){
    final k = key.currentState;
    setState(() {
      k.save();
    });
  }

  void onChangeSearch(String value) async{
    print('value -- > $value');
    if(value =='') {
      setState(() {
      this._list = new List<Restaurant>();
    });
    return ;
    }
    Control control = Control.internal();
    await control.getListForSearch(value)
      .then((onValue){
        setState(() {
          this._list = onValue;
        });
      });
  }
}
