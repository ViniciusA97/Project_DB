import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:project_bd/Model/Preco.dart';
import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/pedidos.dart';
import 'package:project_bd/Model/pratos.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:sqflite/sqflite.dart';
import '../Model/pedidos.dart';
import '../Model/pratos.dart';
import '../Model/restaurant.dart';
import '../Model/restaurant.dart';

class DatabaseHelper {
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
        "CREATE TABLE User(idUser INTEGER PRIMARY KEY , name TEXT, password TEXT, email TEXT UNIQUE, address TEXT , number TEXT );");
    await db.execute(
        "CREATE TABLE Restaurant(idRest INTEGER  PRIMARY KEY, name TEXT UNIQUE, password TEXT, numPedidos INTEGER, image VARCHAR, description VARCHAR, num TEXT, email TEXT UNIQUE, address TEXT, hora_abre INTEGER, hora_fecha INTEGER, entregaGratis INTEGER);");
    await db.execute(
        "CREATE TABLE Prato(idPrato INTEGER  PRIMARY KEY, name TEXT, descricao TEXT, idPreco INTEGER ,img VARCHAR, idRest INT NOT NULL, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest), FOREIGN KEY(idPreco) REFERENCES Preco(idPreco));");
    await db.execute(
        'CREATE TABLE Categoria(idCategoria INTEGER PRIMARY KEY, name VARCHAR, image VARCHAR)');
    await db.execute(
        'CREATE TABLE CategoriaRest(idRest INTEGER, idCategoria INTEGER, FOREIGN KEY(idRest) REFERENCES Categoria(idCategoria), FOREIGN KEY(idRest) REFERENCES Restaurant(idRest))');
    await db.execute(
        'CREATE TABLE Pedidos( idPedido INTEGER PRIMARY KEY, data DATATIME, preco REAL )');
    await db.execute(
        'CREATE TABLE PedidoPratoUser(idUser INTEGER, idPrato INTEGER, quantidade INTEGER, idPedido INTEGER, FOREIGN KEY(idPedido) REFERENCES Prato(idPedido), FOREIGN KEY (idPrato) REFERENCES Prato(idPrato), FOREIGN KEY (idUser) REFERENCES User(idUser))');
    await db.execute(
        'CREATE TABLE Preco(idPreco INTEGER PRIMARY KEY, date SMALLDATETIME, preco REAL)');

    //User(idUser: 1 , name: joao , pass: 1 , email: joao@gmail.com, address: Rua soltino, number: 990)
    //Restaurant(idRest: 0 , name: LePresident , pass: 11 , numPedidos: 20 )
    //Prato(idPrato:20 , name: Sopa de batata, preco: 15.6 , idRest:0)
    //Pedidos(idPedido: 1, data: 03/02/2020)
    //PedidoPratoRestUser( idPrato: 20, idRest:0, idUser: 1)
  }

//insertion
  Future<bool> saveUser(User user) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO User (name, password, email, address, number) VALUES(?,?,?,?,?)",
          [user.name, user.password, user.email, user.address, user.celNumber]);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> saveRest(Restaurant rest) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          "INSERT INTO Restaurant (name, password, numPedidos,image,description,num,email, address) VALUES(?,?,?,?,?,?,?,?)",
          [
            rest.name,
            rest.password,
            rest.numPedidos,
            rest.url,
            rest.descriprion,
            rest.nume,
            rest.email,
            rest.address
          ]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<int> saveRestWithCategorie(
      Restaurant rest, List<Categories> list) async {
    var dbClient = await db;
    int res = await dbClient.rawInsert(
        "INSERT INTO Restaurant (name, password, numPedidos,image,description,num,email, address) VALUES(?,?,?,?,?,?,?,?)",
        [
          rest.name,
          rest.password,
          rest.numPedidos,
          rest.url,
          rest.descriprion,
          rest.nume,
          rest.email,
          rest.address
        ]);
    for (Categories i in list) {
      await dbClient.rawInsert(
          'INSERT INTO CategoriasRest(idRest, idCategoria) VALUES(?,?)',
          [rest.id, i.id]);
    }
    return res;
  }

  Future<bool> savePrato(Prato prato) async {
    var dbClient = await db;
    try {
      dbClient.rawInsert('''INSERT INTO Preco( preco, date) VALUES(?,datetime('now','localtime'))''',
          [prato.preco.preco]);
      dynamic response = await dbClient
          .rawQuery('SELECT idPreco FROM Preco ORDER BY idPreco DESC LIMIT 1');
      print(response[0]['idPedido']);
      int res = await dbClient.rawInsert(
          "INSERT INTO Prato (name,descricao, idPreco, idRest,img) VALUES(?,?,?,?,?)",
          [
            prato.name,
            prato.descricao,
            response[0]['idPreco'],
            prato.idRest,
            prato.img
          ]);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<void> savePedido(Pedido p, double preco) async {
    var dbClient = await db;
    dbClient.rawInsert(
        'INSERT INTO Pedidos(data, preco) VALUES(?,?)', [p.data, preco]);
    dynamic pedido = dbClient.rawQuery(
        'SELECT idPedido From Pedidos ORDER BY idPedido DESC LIMIT 1;');
    int idPedido = pedido[0]['idPedido'];
    List<Prato> pratos;
    for (Prato i in pratos) {
      dbClient.rawInsert(
          'INSERT INTO PedidoPratoUser (idPrato, idUser, idPedido) VALUES(?,?,?)',
          [i.idPrato, p.user.id, idPedido]);
    }
  }

  Future<Categories> saveCategoria(String name, String img) async {
    var dbClient = await db;
    dbClient.rawInsert(
        'INSERT INTO Categoria(name, image) VALUES(?,?)', [name, img]);
    dynamic resp = await dbClient.rawQuery(
        'SELECT idCategoria,name,image FROM Categoria WHERE name =?', [name]);
    return Categories.map(resp[0]);
  }

  Future<void> saveRelacionCatRest(int idRest, int idCat) async {
    var dbClient = await db;
    dbClient.rawInsert(
        'INSERT INTO CategoriaRest(idRest, idCategoria) VALUES(?,?)',
        [idRest, idCat]);
  }

  //ok
  //Busca todas as categorias
  Future<List<Categories>> getAllCategories() async {
    var dbClient = await db;
    dynamic response = await dbClient.rawQuery('SELECT * FROM Categoria');
    print(response);
    List<Categories> list = List<Categories>();
    for (dynamic i in response) {
      list.add(Categories.map(i));
    }
    print(list);
    return list;
  }

  //ok
  //Busca todas as categorias do restaurante
  Future<List<Categories>> getCategorieByIdRest(int idRest) async {
    var dbClient = await db;
    List<Map> resp =
        await dbClient.rawQuery('''
          SELECT 
                CategoriaRest.idCategoria,
                Categoria.name,
                Categoria.image,
                Categoria.idCategoria 
          FROM 
                CategoriaRest INNER JOIN  Categoria ON Categoria.idCategoria = CategoriaRest.idCategoria 
          WHERE 
                CategoriaRest.idRest=?''', [idRest]
          );
    List<Categories> cat = List<Categories>();
    for (var i in resp) {
      cat.add(Categories.map(i));
    }
    return cat;
  }

  //ok
  // pega todos os restaurantes cadastrados em determinada categoria
  Future<List<Restaurant>> getRestByIdCategories(int idCat) async {
    var dbClient = await db;
    dynamic resp = await dbClient.rawQuery(
      '''
      SELECT 
              Restaurant.*,
              Prato.name AS namePrato,
              Prato.img AS imgPrato,
              Prato.idPrato,
              Prato.descricao AS descricaoPrato,
              Preco.idPreco,
              Preco.date,
              Preco.preco
        FROM 
              CategoriaRest INNER JOIN Restaurant ON Restaurant.idRest = CategoriaRest.idRest
              LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
              LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
        WHERE 
              CategoriaRest.idCategoria = $idCat''');
    print('Restaurant test --> $resp');
    List<Restaurant> rests = new List<Restaurant>();
    List<Prato> usual= new List<Prato>();
    int savedIdRest;
    for (dynamic i in resp) {
      rests.add(Restaurant.map(i));
      if(i['idRest'] == savedIdRest ){
        rests.last.addPrato(Prato.mapJOIN(i));
      }
      savedIdRest= i['idRest'];
    }
    return rests;
  }

  Future<List<Restaurant>> getAllRest() async {
    var dbClit = await db;
    List<Map<String, dynamic>> resp = await dbClit.query('Restaurant');
    List<Prato> prato;
    List<Restaurant> list = new List<Restaurant>();
    Restaurant rest;
    print('resp ---> $resp');
    for (int i = 0; i < resp.length; i++) {
      prato = await getPratos(resp[i]['idRest']);
      rest = Restaurant.map(resp[i]);
      rest.setCardapio(prato);
      list.add(rest);
    }

    return list;
  }

  //ok
  //confere se existe usuario, caso exista retorna o mesmo
  Future<User> getUser(String email, String pass) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery(
        'SELECT * FROM User WHERE email=? and password=?',
        [email, pass]);
    try {
      return User.map(test[0]);
    } catch (err) {
      print(err);
      return null;
    }
  }

  //ok
  //busca um user pelo seu id
  Future<User> getUserById(int id) async {
    var dbClient = await db;
    dynamic test =
        await dbClient.rawQuery('SELECT * FROM User WHERE idUser=?', [id]);
    User a = User.map(test);
    return a;
  }

  //ok
  //Confere se existe restaurante, caso exista retorna o mesmo
  Future<Restaurant> getRestLogin(String name, String password) async {
    var dbClient = await db;
    dynamic rest = await dbClient.rawQuery('''
      SELECT 
            Restaurant.*,
            CategoriaRest.idCategoria AS idCategoria,
            Categoria.name AS nameCategoria,
            Categoria.image As imageCategoria,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
            Restaurant LEFT JOIN CategoriaRest ON Restaurant.idRest = CategoriaRest.idRest
            LEFT JOIN Categoria ON CategoriaRest.idCategoria = Categoria.idCategoria
            LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      WHERE 
            Restaurant.name=? and Restaurant.password=?''', [name, password]
    );
    try {
      print('login Rest --> $rest');
      Restaurant usual = Restaurant.map(rest[0]);
      List<Prato> cardapio = await this.getPratos(rest[0]['idRest']);
      List<Categories> categories =
          await this.getCategorieByIdRest(rest[0]['idRest']);
      usual.setCardapio(cardapio);
      usual.setCategories(categories);
      return usual;
    } catch (err) {
      return null;
    }
  }

  //ok
  //Busca um restaurante pelo id
  Future<Restaurant> getRestById(int id) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery(
      '''
      SELECT 
            Restaurant.*,
            CategoriaRest.idCategoria AS idCategoria,
            Categoria.name AS nameCategoria,
            Categoria.image As imageCategoria,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
            Restaurant LEFT JOIN CategoriaRest ON Restaurant.idRest = CategoriaRest.idRest
            LEFT JOIN Categoria ON CategoriaRest.idCategoria = Categoria.idCategoria
            LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      WHERE 
            Restaurant.idRest = $id'''
    );
    print(test);
    try {
      Restaurant temp = Restaurant.map(test[0]);
      List<Prato> listPratos = await getPratos(temp.id);
      temp.setCardapio(listPratos);
      return temp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //ok
  //Pega os pratos ligados ao idRest
  Future<List<Prato>> getPratos(int idRest) async {
    var dbClient = await db;
    List<Map> test = await dbClient.rawQuery(
      '''
      SELECT 
            Prato.*,
            Preco.* 
      FROM 
            Prato LEFT JOIN Preco ON Preco.idPreco = Prato.idPreco
      WHERE 
            Prato.idRest=?''', [idRest]);
    try {
      test[0];
      List<Prato> cardapio = new List<Prato>();
      for(var i in test){
        cardapio.add(Prato.map(i));
      }
      
      return cardapio;
    } catch (err) {
      print(err);
      return null;
    }
  }

  //ok 
  //Pega o preco pelo seu id
  Future<Preco> getPreco(int idPreco) async {
    var dbClient = await db;
    dynamic response =
        dbClient.rawQuery('SELECT * FROM Preco WHERE idPreco=$idPreco');
    return Preco.map(response);
  }

  //ok - não testada
  //Pega o prato pelo seu id
  Future<Prato> getPratoById(int idPrato) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery(
      '''
      SELECT 
            Prato.*,
            Preco.* 
      FROM 
            Prato INNER JOIN Preco ON Preco.idPreco = Prato.idPreco
      WHERE 
            idPrato=?''', [idPrato]);
    print(test);
    try {
      return Prato.map(test[0]);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //ok - não testada
  // Pega todos os pedidos do restaurante
  Future<List<Pedido>> getPedidosByRest(int rest) async {
    var dbClient = await this.db;
    var test = await dbClient.rawQuery(
      '''
      SELECT 
            Prato.*,
            Preco.*,
            Pedidos.*,
            PedidoPratoUser.*
      FROM
            Prato INNER JOIN Preco ON Preco.idPreco = Prato.idPreco
            INNER JOIN PedidoPratoUser ON PedidoPratoUser.idPrato = Prato.idPrato
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Prato.idRest = $rest
      ''');
    List<Prato> pratos = await getPratos(rest);
    try {
      pratos[0];
      List<Pedido> list = List<Pedido>();
      for (Prato a in pratos) {
      }
      return list;
    } catch (err) {
      return null;
    }
  }

  // ok - nao testada
  //Busca o Pedido pelo seu id
  Future<Pedido> getPedidoById(int idPedido) async {
    var dbClient = await db;
    dynamic map = dbClient.rawQuery('''
    SELECT 
          Pedidos.*,
          PedidoPratoUser.*,
          User.*,
          Pratos.*
    FROM 
        Pedidos INNER JOIN PedidoPratoUser ON PedidoPratoUser.idPedido = Pedidos.idPedido
        INNER JOIN User ON User.idUser = Pedidos.idUser
        INNER JOIN Pratos ON Pratos.idPrato = Pedidos.idPrato
    WHERE 
        Pedidos.idPedidos = $idPedido

    
    ''');
    User u = await getUserById(map['idUser']);
    Prato p = await getPratoById(map['idPrato']);
    dynamic fin;
    fin['idPedido'] = idPedido;
    fin['user'] = u;
    fin['prato'] = p;
    Restaurant r = await getRestById(p.idRest);
    fin['rest'] = r;
    fin['data'] = map['data'];
    Pedido pedido = Pedido.map(fin);
    return pedido;
  }

  Future<Prato> getPrato(int idPrato) async {
    var dbClient = await db;
    dynamic map = dbClient.query('Prato',
        columns: ['preco', 'descricao', 'name'],
        where: 'idPrato=?',
        whereArgs: [idPrato]);
    Prato prato = Prato.map(map[0]);
    return prato;
  }

  Future<List<Restaurant>> search(String text) async {
    var dbClient = await db;
    List<Map> response = await dbClient.rawQuery(
      '''SELECT 
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
            Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      WHERE 
            Restaurant.name LIKE '%$text%' OR Prato.name LIKE '%$text%' 
            ''' 
    );
    return transforming(response);
  }

  Future<List<Restaurant>> getRestPopular() async{
    var dbClient = await  this.db;
    List<Map> response = await dbClient.rawQuery('''
      SELECT
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      GROUP BY
          Restaurant.idRest
      HAVING MAX(Preco.preco) < 10.0  
    ''');
    return transforming(response);
  }

  Future<List<Restaurant>> getRestEntregaGratis() async {
    var dbClient = await this.db;
    List<Map> response = await dbClient.rawQuery('''
      SELECT
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      WHERE Restaurant.entregaGratis = 1 
    ''');
    return transforming(response);
  }

  Future<List<Restaurant>> getRestEntregaRapida() async {
    var dbClient = await this.db;
    List<Map> response = await dbClient.rawQuery('''
      SELECT
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.idPreco,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPreco = Preco.idPreco
      WHERE Restaurant.entregaGratis = 0 
    ''');
    return transforming(response);
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  


  List<Restaurant> transforming( List<Map> response){
    try{
      response[0];
      print(response);
      Map<int,Restaurant> map = new Map<int, Restaurant>();
      for(var i in response){
        if(!map.containsKey(i['idRest'])){
          map[i['idRest']] = Restaurant.map(i);
        }else{
          map[i['idRest']].addPrato(Prato.mapJOIN(i));
        }
      }
      List<Restaurant> rest = new List<Restaurant>();
      map.forEach((k,v)=>rest.add(v));
      return rest;
    }catch(err){
      print(err);
      print('deu ruim otaro');
      return new List<Restaurant>();
    }
  }

  Future<List<Pedido>> getPedidosByUser(int idUser) async {
    var dbClient = await this.db;
    var test = await dbClient.rawQuery(
      '''
      SELECT 
            Prato.*,
            Preco.*,
            Pedidos.*,
            PedidoPratoUser.*
            
      FROM 
            PedidoPratoUser 
            INNER JOIN Pedidos ON Pedidos.idPedido =PedidoPratoUser.idPedido 
            INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco on Preco.idPreco = Prato.idPreco
      WHERE 
            PedidoPratoUser.idUser = $idUser
      '''
    );
    try{
      List<Pedido> p = List<Pedido>();
      return p;
    } catch(err) {
        return null;
    }
  }


  //deletion
  

}

  //update



// Categoria : Padaria, Doces & Bolos, Salgados,  Saudavel , Brasileira, cozinha rapida, lanches
//  pizza, japonesa , poke , espetinhos , Hot Dog, Carnes, Açaí
