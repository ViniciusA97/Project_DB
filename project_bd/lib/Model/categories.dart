class Categories{

  String _image;
  String _name;
  int _idCategorie;

  Categories(this._idCategorie,this._image,this._name);

  Categories.map(dynamic obj){
    this._idCategorie = obj['idCategoria'];
    this._image = obj['imageCategoria'];
    this._name = obj['nameCategoria'];
  }

  String get image =>this._image;
  String get name => this._name;
  int get id => this._idCategorie;
}