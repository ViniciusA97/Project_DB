import 'package:flutter/material.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/pages/HomeUserPage/BagPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlatePage extends StatefulWidget {
  Prato _prato;
  PlatePage(this._prato);

  @override
  _PlatePageState createState() => _PlatePageState(_prato);
}

class _PlatePageState extends State<PlatePage> {

  Prato _prato;
  int quant = 1;

  _PlatePageState(this._prato);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page(),
    );
  }

  Widget page()
  {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
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
                      right: MediaQuery.of(context).size.width / 9,),
                ),
                Text(
                  'Detalhes do item',
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
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1
                )),
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                  child: Image.network(
                    '${this._prato.img}',
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height*0.35,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                ),
                Text(
                  '${this._prato.name}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                
                Text(
                  '${this._prato.descricao}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  )
                
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  '\$${this._prato.preco.preco}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  )
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
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            // height: MediaQuery.of(context).size.height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                RawMaterialButton(
                  child: Icon(FontAwesomeIcons.minus, color: Colors.white, size: 10.0,),
                  elevation: 6.0,
                  constraints: BoxConstraints.tightFor(
                    width: 20.0,
                    height: 20.0
                  ),
                  shape: CircleBorder(),
                  fillColor: Color(0xff38ad53),
                  onPressed: () {
                    setState(() {
                      quant<=1?
                       quant = quant: --quant;
                    });
                  },
                ),
                Text(
                  quant.toString(),
                ),
                RawMaterialButton(
                  child: Icon(FontAwesomeIcons.plus, color: Colors.white, size: 10.0,),
                  elevation: 6.0,
                  constraints: BoxConstraints.tightFor(
                    width: 20.0,
                    height: 20.0
                  ),
                  shape: CircleBorder(),
                  fillColor: Color(0xff38ad53),
                  onPressed: () {
                    setState(() {
                      ++quant;
                    });
                  },
                ),
                Material(
                  elevation: 5.0,
                  color: Color(0xff38ad53),
                  child: MaterialButton(
                    minWidth: 100.0,
                    // TODO: Adicionar ao carrinho
                    onPressed: (){
                      print('AAAA');
                      List<Prato> tmp = new List();
                      tmp.add(this._prato);                      
                      List<int> qts = new List();
                      qts.add(this.quant);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BagPage(tmp, qts)));
                    },
                    child: Text('Adicionar     \$${(this._prato.preco.preco) * quant}', style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}