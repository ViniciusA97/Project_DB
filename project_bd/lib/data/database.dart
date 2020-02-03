
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
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
      "CREATE TABLE Prato(idPrato INTEGER  PRIMARY KEY, name TEXT, descricao TEXT, preco INT , idRest INT NOT NULL, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest));");
    await db.execute(
      'CREATE TABLE ImagesRestaurant (idImage INTEGER PRIMARY KEY, url VARCHAR NOT NULL, idRest INTEGER, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest));');
    await db.execute(
      'CREATE TABLE TipoPrato( idTipo INTEGER PRIMARY KEY, tipo VARCHAR, idRest INTEGER, idPrato INTEGER , FOREIGN KEY(idRest) REFERENCES Restaurant(idRest), FOREIGN KEY(idPrato) REFERENCES Prato(idPrato))'
    );
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
    int res = await dbClient.rawInsert("INSERT INTO Prato (name,descricao, preco, idRest) VALUES(${prato.name},${prato.descricao},${prato.preco}, ${prato.id})");
    return res;
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

  Future<List<Map<String,dynamic>>> getAllRest() async{
    var dbClit = await db;
    dynamic resp = await dbClit.query('Restaurant');
    return resp;

  }


  Future<User> getUser(String email, String pass) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("User",
    columns: ["password", "name", 'number', 'idUser', 'address'],
    where: "email =?",
    whereArgs: ["$email"]
    );
    print(test);

    try{
      if(test[0]['password'] == pass){
        User a = User.map(test);
        User temp = new User( test[0]['name'],pass,email,test[0]['address'],test[0]['number'] );
        return temp;
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
        
        return temp;
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<List<Prato>> getPratos(int idRest) async{
    var dbClient = await db;
    dynamic test = await dbClient.query("Pratos",
    columns: ["preco", 'descricao','name'],
    where: "idRest =?",
    whereArgs: ["$idRest"]
    );
    print(test);

    try{
        List<Prato> cardapio = new List<Prato>();
        for(var a in test){
          Prato usual = new Prato(idRest,a['name'], a['preco'], a['descricao']) ;
          cardapio.add(usual);
        }
        return cardapio;
      
    }catch(e){
      print(e.toString());
    }
    return null;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }
}


