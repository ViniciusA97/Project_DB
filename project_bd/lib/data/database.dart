import 'dart:io';
import 'package:flutter/material.dart';
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
import '../Model/itemCart.dart';

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
        "CREATE TABLE Restaurant(idRest INTEGER  PRIMARY KEY, name TEXT UNIQUE, password TEXT, numPedidos INTEGER, image VARCHAR, description VARCHAR, num TEXT, email TEXT UNIQUE, address TEXT, hora_abre SMALLDATETIME, hora_fecha SMALLDATETIME, entregaGratis INTEGER);");
    await db.execute(
        "CREATE TABLE Prato(idPrato INTEGER  PRIMARY KEY, name TEXT, descricao TEXT,img VARCHAR, idRest INT NOT NULL, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest));");
    await db.execute(
        'CREATE TABLE Categoria(idCategoria INTEGER PRIMARY KEY, name VARCHAR, image VARCHAR)');
    await db.execute(
        'CREATE TABLE CategoriaRest(idRest INTEGER, idCategoria INTEGER, FOREIGN KEY(idRest) REFERENCES Categoria(idCategoria), FOREIGN KEY(idRest) REFERENCES Restaurant(idRest))');
    await db.execute(
        'CREATE TABLE Pedidos( idPedido INTEGER PRIMARY KEY, data DATATIME, preco REAL, adress TEXT)');
    await db.execute(
        'CREATE TABLE PedidoPratoUser(idUser INTEGER, idPrato INTEGER, quantidade INTEGER, idPedido INTEGER, FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido), FOREIGN KEY (idPrato) REFERENCES Prato(idPrato), FOREIGN KEY (idUser) REFERENCES User(idUser))');
    await db.execute(
        'CREATE TABLE Preco(idPreco INTEGER PRIMARY KEY, date SMALLDATETIME, preco REAL, idPrato INTEGER, FOREIGN KEY(idPrato) REFERENCES Prato(idPrato))');
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
          "INSERT INTO Restaurant (name, password,image,description,num,email,address,hora_abre, hora_fecha, entregaGratis ) VALUES(?,?,?,?,?,?,?,?,?,?)",
          [
            rest.name,
            rest.password,
            rest.url,
            rest.descriprion,
            rest.nume,
            rest.email,
            rest.address,
            rest.horaAbre.toString(),
            rest.horaFecha.toString(),
            rest.entregaGratis
          ]);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> savePrato(Prato prato) async {
    var dbClient = await db;
    try {
      int res = await dbClient.rawInsert(
          "INSERT INTO Prato (name,descricao, idRest,img) VALUES(?,?,?,?)",
          [prato.name, prato.descricao, prato.idRest, prato.img]);

      dynamic response = await dbClient
          .rawQuery('SELECT idPrato FROM Prato ORDER BY idPrato DESC LIMIT 1');

      dbClient.rawInsert(
          '''INSERT INTO Preco( preco, date, idPrato) VALUES(?,datetime('now','localtime'), ?)''',
          [prato.preco.preco, response[0]['idPrato']]);

      print(response[0]['idPedido']);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> savePedido(Pedido p, double preco) async {
    try {
      var dbClient = await db;
      await dbClient.rawInsert( '''INSERT INTO Pedidos(data, preco, adress) VALUES(datetime('now','localtime'),?,?)''',[preco, p.adress]);
      dynamic pedido = await dbClient.rawQuery( 'SELECT idPedido From Pedidos ORDER BY idPedido DESC LIMIT 1');
      int idPedido = pedido[0]['idPedido'];
      print('idpedido---->$idPedido');
      List<Prato> pratos = p.prato;
      List<int> qnt = p.qnt;
      print('${pratos.length}  ${qnt.length}');

      for (int i = 0; i < pratos.length; i++) {
        print('idprato --> ${pratos[0].idPrato}');
        await dbClient.rawInsert(
            'INSERT INTO PedidoPratoUser (idPrato, idUser, idPedido, quantidade) VALUES(?,?,?,?)',
            [pratos[i].idPrato, p.user.id, idPedido, qnt[i]]);
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<void> updateEntrega(Restaurant res, int a) async {
    var dbClient = await db;
    // Usei update pq já inicializo com 0 no cadastro
    // entrega é inteiro 1 - gratis 2 - rapida  0 - não definida
    await dbClient.rawUpdate('''
      UPDATE Restaurant
      SET entregaGratis=?
      WHERE Restaurant.idRest=?
      ''', [a, res.id]);
    // res.setEntrega(a);
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

  Future<void> saveOpenTime(int idRest, DateTime time) async {
    var dbClient = await db;
    try {
      dbClient.rawUpdate('''
        UPDATE Restaurant
        SET hora_abre=datetime('$time')
        WHERE Restaurant.idRest=$idRest
        ''');
    } catch (e) {
      print(e);
    }

    List<Map> open = await dbClient
        .rawQuery('SELECT * FROM Restaurant WHERE Restaurant.idRest=$idRest');

    print(open[0]['hora_abre']);
  }

  Future<void> saveCloseTime(int idRest, DateTime time) async {
    var dbClient = await db;
    try {
      dbClient.rawUpdate('''
        UPDATE Restaurant
        SET hora_fecha=datetime('$time')
        WHERE Restaurant.idRest=$idRest
        ''');
    } catch (e) {
      print(e);
    }

    List<Map> close = await dbClient.rawQuery(
        'SELECT hora_fecha FROM Restaurant WHERE Restaurant.idRest=$idRest');
    print(close[0]['hora_fecha']);
  }

  // Atualiza o preco do prato
  Future<bool> updatePrecoPrato(double preco, int id) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert('''
        INSERT INTO Preco(preco, date,idPrato) VALUES( $preco ,  datetime('now','localtime'), $id)
        ''');
      print(DateTime.now().toString().substring(0, 19));
      return true;
    } catch (err) {
      print(err);
      return false;
    }
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
    List<Map> resp = await dbClient.rawQuery('''
          SELECT 
                CategoriaRest.idCategoria,
                Categoria.name,
                Categoria.image,
                Categoria.idCategoria 
          FROM 
                CategoriaRest INNER JOIN  Categoria ON Categoria.idCategoria = CategoriaRest.idCategoria 
          WHERE 
                CategoriaRest.idRest=?''', [idRest]);
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
    dynamic resp = await dbClient.rawQuery('''
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
              LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
        WHERE 
              CategoriaRest.idCategoria = $idCat 
        ORDER BY Preco.idPreco DESC
              ''');
    print('Restaurant test --> $resp');
    List<Restaurant> rests = new List<Restaurant>();
    List<Prato> usual = new List<Prato>();
    int savedIdRest;
    for (dynamic i in resp) {
      rests.add(Restaurant.map(i));
      if (i['idRest'] == savedIdRest) {
        rests.last.addPrato(Prato.mapJOIN(i));
      }
      savedIdRest = i['idRest'];
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
      print(resp[i]['hora_abre']);
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
        'SELECT * FROM User WHERE email=? and password=?', [email, pass]);
    try {
      print('test $test');
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
  Future<Restaurant> getRestLogin(String email, String password) async {
    var dbClient = await db;
    print('eai');
    List<Map> rest = await dbClient.rawQuery('''
      SELECT 
            Restaurant.*,
            CategoriaRest.idCategoria AS idCategoria,
            Categoria.name AS nameCategoria,
            Categoria.image As imageCategoria,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            MAX(Preco.idPreco),
            Preco.*
      FROM 
            Restaurant LEFT JOIN CategoriaRest ON Restaurant.idRest = CategoriaRest.idRest
            LEFT JOIN Categoria ON CategoriaRest.idCategoria = Categoria.idCategoria
            LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
      WHERE 
            Restaurant.email=? and Restaurant.password=? 
      GROUP BY Prato.idPrato
    
            ''', [email, password]);
    try {
      print('login Rest --> $rest');
      Restaurant usual = Restaurant.map(rest[0]);

      return usual;
    } catch (err) {
      print(err);
      return null;
    }
  }

  //ok
  //Busca um restaurante pelo id
  Future<Restaurant> getRestById(int id) async {
    var dbClient = await db;
    dynamic test = await dbClient.rawQuery('''
      SELECT 
            Restaurant.*,
            CategoriaRest.idCategoria AS idCategoria,
            Categoria.name AS nameCategoria,
            Categoria.image As imageCategoria,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
            Restaurant LEFT JOIN CategoriaRest ON Restaurant.idRest = CategoriaRest.idRest
            LEFT JOIN Categoria ON CategoriaRest.idCategoria = Categoria.idCategoria
            LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
      WHERE 
            Restaurant.idRest = $id
      GROUP BY Prato.idPrato
            ''');
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
    List<Map> test = await dbClient.rawQuery('''
      SELECT 
            Prato.*,
            MAX(Preco.idPreco),
            Preco.* 
      FROM 
            Prato LEFT JOIN Preco ON Preco.idPrato = Prato.idPrato
      WHERE 
            Prato.idRest=?
      GROUP BY Prato.idPrato
            ''', [idRest]);
    try {
      test[0];
      List<Prato> cardapio = new List<Prato>();
      for (var i in test) {
        cardapio.add(Prato.map(i));
      }

      return cardapio;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<List<Restaurant>> getRestPromocao() async {
    var dbClient = await db;
    String preDate =
        DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 19);
    String atualDate = DateTime.now().toString().substring(0, 19);
    dynamic response = await dbClient.rawQuery('''
        SELECT 
              Restaurant.*,
              Prato.idPrato,
              Prato.name AS namePrato,
              Prato.descricao AS descricaoPrato,
              Prato.img AS imgPrato,
              Preco.idPreco,
              Preco.preco,
              AVG(Preco.preco) AS mediaPreco
          FROM 
              Preco
              LEFT JOIN Prato on Preco.idPrato = Prato.idPrato
              LEFT JOIN Restaurant on Prato.idRest = Restaurant.idRest
              
          WHERE 
              Preco.date > '$preDate' AND Preco.date < '$atualDate'
          GROUP BY 
              Prato.idPrato
          HAVING 
                Preco.preco <= mediaPreco/2
      ''');
    print(' -->$response');
    List<Restaurant> rest = transforming(response);
    return rest;
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
    dynamic test = await dbClient.rawQuery('''
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

  Future<Pedido> getRelatorio1(int idRest) async{
    var dbClient = await this.db;
    List<Map> test =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*,
            SUM(PedidoPratoUser.quantidade) AS qntPedidoPrato
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest
      GROUP BY
            Prato.idPrato
      ORDER BY 
            qntPedidoPrato DESC
      LIMIT 1
      '''
    );
    try{
      Pedido pedido = Pedido.map(test[0]);
      pedido.addPrato(Prato.mapJOIN(test[0]));
      pedido.addQnt(test[0]['qntPedidoPrato']);
      return pedido;
    }catch(err){
      return null;
    }    
  }


  Future<List<Pedido>> getRelatorio2_1day(int idRest) async{
    String date1 = DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            PedidoPratoUser.idPedido 
      ORDER BY Pedidos.data DESC
      '''
      );
    Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test1){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.map(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;
  }

  

  Future<List<Pedido>> getRelatorio2_7days(int idRest) async{
    String date1 = DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      '''
      );
    Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test1){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.map(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;
  }
  

  Future<List<Pedido>> getRelatiorio2_30days(int idRest) async{
    var dbClient = await this.db;
    String date15 = DateTime.now().subtract(Duration(days: 30)).toString().substring(0, 19);
      List<Map> test =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date15'
      GROUP BY
            PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      '''
      );
      Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.map(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;

  }

//não esta completo
  Future<List<Pedido>> getRelatorio3(int idRest) async{
    String date1 = DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*,
            SUM(PedidoPratoUser.quantidade) AS sumQnt,
            SUM(Pedidos.preco) AS media
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            Prato.idPrato
      ORDER BY Pedidos.data DESC
      '''
      );
      print(test1);
    Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test1){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.mapRelatorio(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;
  }

  

  //ok - não testada
  // Pega todos os pedidos do restaurante
  Future<List<Pedido>> getPedidosByRest(int rest) async {
    var dbClient = await this.db;
    dynamic test = await dbClient.rawQuery('''
      SELECT 
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Pedidos.*,
            Restaurant.*,
            PedidoPratoUser.*,
            User.name AS nameUser,
            User.email AS emailUser,
            User.address AS addressUser,
            User.number AS numberUser
      FROM
            PedidoPratoUser 
            INNER JOIN Pedidos ON Pedidos.idPedido =PedidoPratoUser.idPedido 
            INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN User on User.idUser = PedidoPratoUser.idUser
      WHERE
            Prato.idRest = $rest
      GROUP BY
            PedidoPratoUser.idPedido
      ''');
    Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.map(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;
  }

  Future<List<Restaurant>> getMaisPedidos() async{
    var dbClient = await this.db;
    String date = DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 19);
    List<Map> test =await  dbClient.rawQuery(
      '''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*,
            SUM(PedidoPratoUser.quantidade) AS qntPedidoPrato
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Pedidos.data>'$date' 
      GROUP BY
            Prato.idPrato
      ORDER BY 
            qntPedidoPrato DESC
      LIMIT 5
      '''
      );
      List<Restaurant> rests = transforming(test);
      return rests;
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
    List<Map> response = await dbClient.rawQuery('''SELECT 
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
            Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
      WHERE 
            Restaurant.name LIKE '%$text%' OR Prato.name LIKE '%$text%' 
            ''');
    return transforming(response);
  }

  Future<List<Restaurant>> getRestPopular() async {
    var dbClient = await this.db;
    List<Map> response = await dbClient.rawQuery('''
      SELECT
            Restaurant.*,
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
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
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
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
            Prato.img AS imgPrato,
            Preco.idPreco,
            Preco.date,
            Preco.preco
      FROM 
          Restaurant LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
          LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
      WHERE Restaurant.entregaGratis = 2 
    ''');
    return transforming(response);
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  List<Restaurant> transforming(List<Map> response) {
    try {
      response[0];
      print(response);
      Map<int, Restaurant> map = new Map<int, Restaurant>();
      for (var i in response) {
        if (!map.containsKey(i['idRest'])) {
          map[i['idRest']] = Restaurant.map(i);
        } else {
          map[i['idRest']].addPrato(Prato.mapJOIN(i));
        }
      }
      List<Restaurant> rest = new List<Restaurant>();
      map.forEach((k, v) => rest.add(v));
      return rest;
    } catch (err) {
      print(err);
      print('deu ruim otaro');
      return new List<Restaurant>();
    }
  }

  Future<List<Pedido>> getPedidosByUser(int idUser) async {
    var dbClient = await this.db;
    print('id user->$idUser');
    List<Map> test = await dbClient.rawQuery('''
      SELECT 
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Pedidos.*,
            Restaurant.*,
            PedidoPratoUser.*,
            User.name AS nameUser,
            User.email AS emailUser,
            User.address AS addressUser,
            User.number AS numberUser 
      FROM 
            PedidoPratoUser 
            INNER JOIN Pedidos ON Pedidos.idPedido =PedidoPratoUser.idPedido 
            INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN User on User.idUser = PedidoPratoUser.idUser
      WHERE 
            PedidoPratoUser.idUser = $idUser
      GROUP BY  
            PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');
    
      print('test--> $test');
      Map<int, Pedido> map = new Map<int, Pedido>();
      for(var i in test){
        if(!map.containsKey(i['idPedido'])){
          map[i['idPedido']] = Pedido.map(i);
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }else{
          map[i['idPedido']].addPrato(Prato.mapJOIN(i));
          map[i['idPedido']].addQnt(i['quantidade']);
        }
      print('maaap --> $map');
      }
      List<Pedido> pedidos = new List<Pedido>();
      map.forEach((k, v) => pedidos.add(v));
      return pedidos;
  
  }

  Future<bool> saveCart(ItemCart c) async {
    var dbClient = await db;
    try {
      await dbClient.rawInsert(
          'INSERT INTO Carrinho(idPrato, quant) VALUES(?,?)',
          [c.prato.idPrato, c.quant]);
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<Map<Prato, int>> getCart() async {
    var dbClient = await db;

    dynamic idsItens = await dbClient.rawQuery('SELECT * FROM Carrinho');
    Map<Prato, int> list = Map<Prato, int>();

    for (dynamic m in idsItens) {
      dynamic test = await dbClient.rawQuery('''
        SELECT 
              Prato.*,
              Preco.* 
        FROM 
              Prato INNER JOIN Preco ON Preco.idPrato = Prato.idPrato
        WHERE 
              Preco.idPrato=?''', [m['idPrato']]);
      int quant = m['quant'];
      try {
        print("\n\n\n Pegou prato ${test[0]['name']} com $quant quantidades");
        list.addAll({Prato.map(test[0]): quant});
      } catch (e) {
        print(e.toString());
      }
    }
    print(list);
    return list;
  }

  //deletion
  Future<int> clearCart() async {
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE From Carrinho");
    return res;
  }

  Future<bool> removeItemCart(Prato p, int quant) async {
    var dbClient = await db;
    try {
      await dbClient.rawDelete(
          "DELETE From Carrinho WHERE idPrato=${p.idPrato} AND quant=$quant;");
      print(true);
      return true;
    } catch (err) {
      print(false);
      return false;
    }
  }
}

//update

// Categoria : Padaria, Doces & Bolos, Salgados,  Saudavel , Brasileira, cozinha rapida, lanches
//  pizza, japonesa , poke , espetinhos , Hot Dog, Carnes, Açaí
