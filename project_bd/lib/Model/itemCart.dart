import 'package:project_bd/Model/pratos.dart';
class ItemCart{


  Prato _prato;
  int _quant;


  ItemCart(this._prato, this._quant);
  
  ItemCart.map(dynamic obj) {

    this._prato = obj['prato'];
    this._quant = obj['quant'];
  }


  Prato get prato => _prato;
  int get quant => _quant;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['prato'] = _prato;
    map['quant'] = _quant;
    return map;
  }
}