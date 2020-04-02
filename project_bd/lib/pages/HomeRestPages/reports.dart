import 'package:flutter/material.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/pages/HomeRestPages/reportList.dart';

class Report extends StatefulWidget {

  Restaurant _restaurant;
  Report(this._restaurant);

  @override
  _ReportState createState() => _ReportState(this._restaurant);
}

class _ReportState extends State<Report> {

  Restaurant _restaurant;
  _ReportState(this._restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: header(),
    );
  }

  Widget header(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50)),
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
                    right: MediaQuery.of(context).size.width / 7,
                  ),
                ),
                Text(
                  'RELATÓRIOS',
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
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.87,
            child: body(),
          ),
        ],
      ),
    );
  }

  Widget body(){
    return ListView(
      children: <Widget>[
        DefaultTabController(
          length: 3, 
          child: Column(
            children: <Widget>[
              TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                indicatorColor: Color(0xff38ad53),
                tabs: <Widget>[
                  Tab(
                    text: '1 dia',
                  ),
                  Tab(
                    text: '7 dias',
                  ),
                  Tab(
                    text: '30 dias',
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 50,
                child: TabBarView(
                  children: <Widget>[
                    getOneDayReport(),
                    getSevenDaysReport(),
                    getThirtyDaysReport()
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getOneDayReport(){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20)),
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child:null, // TODO: Chamar ReportList
            ),
          ],
        ),
      ],
    );
  }

  Widget getSevenDaysReport(){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20)),
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: null, // TODO: Chamar ReportList
            ),
          ],
        ),
      ],
    );
  }

  Widget getThirtyDaysReport(){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20)),
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: null, // TODO: Chamar ReportList
            ),
          ],
        ),
      ],
    );
  }
}