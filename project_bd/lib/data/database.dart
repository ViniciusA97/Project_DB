
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  // Create table
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(idUser INTEGER PRIMARY KEY , name TEXT, password TEXT, email TEXT, address TEXT , number TEXT );");
    await db.execute(
        "CREATE TABLE Restaurant(idRest INTEGER  PRIMARY KEY, name TEXT, password TEXT, numPedidos INTEGER, image VARCHAR, description VARCHAR, num TEXT, email TEXT, address TEXT);");
    await db.execute(
      "CREATE TABLE Prato(idPrato INTEGER  PRIMARY KEY, name TEXT, descricao TEXT, preco REAL ,img VARCHAR, idRest INT NOT NULL, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest));");
    await db.execute(
      'CREATE TABLE TipoPrato( idTipo INTEGER PRIMARY KEY, tipo VARCHAR, idRest INTEGER, idPrato INTEGER , FOREIGN KEY(idRest) REFERENCES Restaurant(idRest), FOREIGN KEY(idPrato) REFERENCES Prato(idPrato))');
    await db.execute(
      'CREATE TABLE Pedidos(idPedido INTEGER PRIMARY KEY, data DATATIME , preco INTEGER)');
    await db.execute(
      'CREATE TABLE PedidoPratoRestUser(idPrato INTEGER, idRest INTEGER, idUser, FOREIGN KEY(idPrato) REFERENCES Prato(idPrato), FOREIGN KEY(idUser) REFERENCES User(idUser), FOREIGN KEY (idRest) REFERENCES Restaurant(idRest))');
   
    //User(idUser: 1 , name: joao , pass: 1 , email: joao@gmail.com, address: Rua soltino, number: 990)
    //Restaurant(idRest: 0 , name: LePresident , pass: 11 , numPedidos: 20 )
    //Prato(idPrato:20 , name: Sopa de batata, preco: 15.6 , idRest:0)
    //Pedidos(idPedido: 1, data: 03/02/2020)
    //PedidoPratoRestUser( idPrato: 20, idRest:0, idUser: 1)
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.rawInsert("INSERT INTO User (name, password, email, address, number) VALUES(?,?,?,?,?)",[user.name,user.password,user.email, user.address, user.celNumber]);
    return res;
  }

  Future<int> saveRest(Restaurant rest) async {
    var dbClient = await db;
    int res = await dbClient.rawInsert("INSERT INTO Restaurant (name, password, numPedidos,image,description,num,email, address) VALUES(?,?,?,?,?,?,?,?)",[rest.name,rest.password,rest.numPedidos, rest.url, rest.descriprion,rest.nume,rest.email,rest.address]);
    return res;
  }

  Future<int> savePrato(Prato prato, int idRest) async {
    var dbClient = await db;
    int res = await dbClient.rawInsert("INSERT INTO Prato (name,descricao, preco, idRest,img) VALUES(?,?,?,?,?)",[prato.name,prato.descricao,prato.preco,idRest,prato.img]);
    return res;
  }

  Future<int> savePedido(Pedido p) async{
    var dbClient = await db;
    return
    dbClient.rawInsert('INSERT INTO Pedidos(data) VALUES(?)',[p.data]);
  }


  //confere se existe user
  Future<bool> existUser(String email, String pass) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("User",
    columns: ["password", "name", 'number', 'idUser', 'address'],
    where: "email =?",
    whereArgs: ["$email"]
    );

    try{
      if(test[0]['password'] == pass){
        return true;
      }
    }catch(E){
      return false;
    }
    return false;
  }

   Future<bool> existRest(String email, String pass) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Restaurant",
    columns: ["password", "name"],
    where: "name =?",
    whereArgs: ["$email"]
    );
    print(test);

    try{
      if(test[0]['password'] == pass){
        return true;
      }
    }catch(E){
      return false;
    }
    return false;
  }
  
  //Busca
  Future<List<Restaurant>> getAllRest() async{
    var dbClit = await db;
    dynamic resp = await dbClit.query('Restaurant');
    dynamic prato;
    List<Restaurant> list = new List<Restaurant>();    
    for(dynamic i in resp){
      prato = getPratos(i['idRest']);
      i['pratos']= prato;
      list.add(Restaurant.map(i));
    }

    return list;

  }

  Future<User> getUser(String email, String pass) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("User",
    columns: ["password", "name", 'number', 'idUser', 'address'],
    where: "email =?",
    whereArgs: ["$email"]
    );
    try{
      if(test[0]['password'] == pass){
        User a = User.map(test[0]);
        return a;
      }
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  Future<Restaurant> getRest(String name) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Restaurant",
    columns: ['idRest, name, password , numPedidos , image , description , email, address, num'],
    where: "name =?",
    whereArgs: ["$name"]
    );
    print(test);
    try{
      Restaurant temp = Restaurant.map(test[0]);
      List<Prato> listPratos= await getPratos(temp.id);
      temp.setCardapio(listPratos);
      return temp;
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<List<Prato>> getPratos(int idRest) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Prato",
    columns: ["preco", 'descricao','name','img'],
    where: "idRest =?",
    whereArgs: ["$idRest"]
    );
    print(test);
    try{
        List<Prato> cardapio = new List<Prato>();
        for(var a in test){
          Prato usual = new Prato(idRest,a['name'], a['preco'], a['descricao'],a['img']) ;
          cardapio.add(usual);
        }
        return cardapio;
      
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  Future<Prato> getPrato(int idPrato) async{
    var dbClient = await db;
    dynamic map = dbClient.query('Prato',
      columns:['preco', 'descricao','name'],
      where: 'idPrato=?',
      whereArgs:[idPrato] 
    );
    Prato prato = Prato.map(map[0]);
    return prato;
  }


  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
}


