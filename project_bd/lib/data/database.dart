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
        "CREATE TABLE Prato(idPrato INTEGER  PRIMARY KEY, active INTEGER DEFAULT 1, name TEXT, descricao TEXT,img VARCHAR, idRest INT NOT NULL, FOREIGN KEY(idRest) REFERENCES Restaurant(idRest));");
    await db.execute(
        'CREATE TABLE Categoria(idCategoria INTEGER PRIMARY KEY, name VARCHAR UNIQUE, image VARCHAR)');
    await db.execute(
        'CREATE TABLE CategoriaRest(idRest INTEGER, idCategoria INTEGER, FOREIGN KEY(idRest) REFERENCES Categoria(idCategoria), FOREIGN KEY(idRest) REFERENCES Restaurant(idRest))');
    await db.execute(
        'CREATE TABLE Pedidos( idPedido INTEGER PRIMARY KEY, data DATATIME, precoTotal REAL, adress TEXT)');
    await db.execute(
        'CREATE TABLE Preco(idPreco INTEGER PRIMARY KEY, date SMALLDATETIME, preco REAL, idPrato INTEGER, FOREIGN KEY(idPrato) REFERENCES Prato(idPrato))');
    await db.execute(
        'CREATE TABLE PedidoPratoUser(idUser INTEGER, idPrato INTEGER, quantidade INTEGER, idPedido INTEGER, idPreco INTEGER, FOREIGN KEY(idPreco) REFERENCES Preco(idPreco),FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido), FOREIGN KEY (idPrato) REFERENCES Prato(idPrato), FOREIGN KEY (idUser) REFERENCES User(idUser))');
    //User(idUser: 1 , name: joao , pass: 1 , email: joao@gmail.com, address: Rua soltino, number: 990)
    //Restaurant(idRest: 0 , name: LePresident , pass: 11 , numPedidos: 20 )
    //Prato(idPrato:20 , name: Sopa de batata, preco: 15.6 , idRest:0)
    //Pedidos(idPedido: 1, data: 03/02/2020)
    //PedidoPratoRestUser( idPrato: 20, idRest:0, idUser: 1)


    await db.execute('''
        INSERT INTO User(name, password, email, address, number) values("test","test","test","test","test");
        ''');
    await db.execute('''
          INSERT INTO Restaurant(name, password,image,description,num,address,email,hora_abre, hora_fecha, entregaGratis ) VALUES("Texas","123","https://media-cdn.tripadvisor.com/media/photo-s/16/a2/c7/26/nosso-salao-interno-super.jpg"," Restaunte com comida gostosa","99887766", "Rua Boa vista 33","texas@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",1),
          
          ("Sweet","123","https://media-cdn.tripadvisor.com/media/photo-s/06/37/ca/b7/sweet-garden-cafe-restaurant.jpg", "Restaunte especializado em doces","99887766", "Rua Doceria 43","sweet@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",1),
          
          ("Cafeteria","123","https://image.chavesnamao.com.br/api/view/iK7w62_emrjOv4hgDHFsWnpOxts=/412x400/filters:quality(90)/blog-cnm/2016/09/cafeteria.jpg", "Restaunte especializado em Cafés","99887766", "Rua cafeteria 55","cafeteria@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",0),
          
          ("Hamburgueria","123","https://media-cdn.tripadvisor.com/media/photo-s/12/44/cc/ce/nosso-x-picanha-especial.jpg", "Restaunte especializado em Hamburguer","99887766", "Rua Hamburgueria 99","hamburgueria@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",0),
          
          ("Saladex","123","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTk7X0Aulb0EqkDU0iFG2l8hwYufMEiULM7lTgXTKNijuWtekAW&usqp=CAU"," Restaunte especializado em Salada","99887766", "Rua da salada 67","saladex@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",0),
          
          ("Massa","123","https://abrilvejario.files.wordpress.com/2016/11/massa_ambiente_foto-tomas-rangel-2.jpeg?quality=70&strip=info&w=920", "Restaunte especializado em massas","99887766", "Rua da Massa 13","massa@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",0),
          
          ("Pizzaria","123","https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000jZ3P9MAK/5a2fd72de4b0b6c56629e7ae.jpg&w=710&h=462", "Restaunte especializado em pizza","99887766", "Rua da pizza 233","pizzaria@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",1),
          
          ("Choperia","123","https://i.ytimg.com/vi/_bzHBzwWu6U/maxresdefault.jpg", "Restaunte especializado em chopp","99887766", "Rua da embreagues 233","chopp@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",1),
          
          ("Japones","123","https://media-cdn.tripadvisor.com/media/photo-s/03/a2/90/81/restaurante-japones-dao.jpg", "Restaunte especializado em comida japonesa","99887766", "Rua do japinha 233","japa@gmail.com","2020-04-01 00:00:00.000","2020-04-01 19:00:00.000",1);    
    
    ''');

    await db.execute('''
        INSERT INTO Prato (name,descricao, idRest,img) 
        VALUES("Carne com fritas", "Carne de sol com batatas fritas acompanhado de alface e cebola",1,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQAorAZWxXo6QEiwrkpMcF0Fu5xT8uE8gfQYJIL6Ly78mqHj6ZD&usqp=CAU"),
        ("Frango a passarinha", "Frango a passarinha frita com alho e temperos",1,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS5FRxlIuWAmwjwdF2oxoaNIkqTzWXkj7QLVNRvFsXlckBPw0fI&usqp=CAU"),
        ("Calabresa acebolada", "Calabresa frita com cebolas",1,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSs1iSmt2rup6TsGu-DyantOxNgWgerY9hLzbIojGi3rn6dKKJS&usqp=CAU"),
        ("Caldinho de feijão", "Caldinho de feijão com ovo de codorna e torresmo frito",1,"https://i.ytimg.com/vi/EZxg3fihC94/maxresdefault.jpg"),
        ("Torta alemã", "Fatia média de torta alemã",2,"https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2018/08/09/tortaholandesa.jpg"),
        ("Bolo de morango", "Fatia média de bolo de morgano",2,"https://p2.trrsf.com/image/fget/cf/800/450/middle/images.terra.com/2017/12/18/morangosnobolo.jpg"),
        ("MilkShake", "Milkshake de varios sabores",2,"https://p2.trrsf.com/image/fget/cf/940/0/images.terra.com/2018/07/31/milk-shake-de-caramelo.jpg"),
        ("Brownie", "Brownie",2,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQaugzWOwni7C3eAbn3YhbEu7VjMkdEJWJhGEnRfdyPWbbXwo5f&usqp=CAU"),
        ("Café expresso", "Cafe expresso sem açucar",3,"https://upload.wikimedia.org/wikipedia/commons/2/23/Captura_de_Tela_2017-08-30_%C3%A0s_23.42.42.png"),
        ("Cappuccino", "Cappuccino",3,"https://img.elo7.com.br/product/zoom/2539449/painel-adesivo-cappuccino-cafe-expresso-leite-p-comercio-hd-adesivo-mercadinho.jpg"),
        ("Café com leite", "Café com leite",3,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ5lcLCyGYrq3SmKMfJTJ2UvB1E0EJK6Qv5Q8QVXefuiPGcqLEv&usqp=CAU"),
        ("Café com chantilly", "Café delicioso com chantilly por cima",3,"https://abrilmdemulher.files.wordpress.com/2016/10/receita-frape-de-cafe-com-chantilly.jpg?quality=90&strip=info&w=620&h=372&crop=1"),
        ("X-Tudo", "X-Tudo com tudo que temos direito",4,"https://media-cdn.tripadvisor.com/media/photo-s/0b/ed/c8/10/x-tudo.jpg"),
        ("X-Baccon", "X-Baccon com bastante baccon e queijo chedar",4,"https://prazeresdamesa.uol.com.br/wp-content/uploads/2018/08/x-bacon-cl%C3%A1ssico-1-411x405.jpeg"),
        ("Beirute", "Delicioso sanduba de tradição indiana",4,"https://www.receitasnestle.com.br/images/default-source/recipes/beirute-de-carne_alta.jpg"),
        ("Misto quente", "Misto feito na chapa",4,"https://t1.uc.ltmcdn.com/pt/images/4/6/0/img_como_fazer_um_misto_quente_24064_orig.jpg"),
        ("Salada de rabanete", "Salada de rabanete",5,"https://img.cybercook.com.br/receitas/145/salada-de-rabanete-600x600.jpeg"),
        ("Salada de Frutas","Saladas de frutas com grande variações de fruta",5,"https://img.cybercook.com.br/receitas/84/salada-de-frutas-2-623x350.jpeg"),
        ("Salada de Atum","Saladas de verduras com atum",5,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTKZnRcD2Qw_tHYSMfcVW1LYHfF2m0pq1xXEVx1I6R4R4sGlgA5&usqp=CAU"),
        ("Salada de grão de bico","Saladas de verduras com grão de bico",5,"https://abrilmdemulher.files.wordpress.com/2016/10/receita-salada-de-grao-de-bico-cenoura-e-batata.jpg?quality=90&strip=info&w=620&h=372&crop=1"),
        ("Massa com espinafre","Massa acompanhada de molho de espinafre",6,"https://img.cybercook.com.br/receitas/460/massa-com-espinafre-2-623x350.jpeg"),
        ("Massa com camarão","Massa acompanhada de camarão e molho de tomate",6,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ8lbje3aat-9p2Tmy4Qzxr3-ZU3VQBsTQ1DYHPTfQlgKHa9Cvl&usqp=CAU"),
        ("Carbonara","Massa com guanchale, queijo e ovo",6,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRCf3ZJ0ns6CegDANhzHiQtP3agLC8AbZEJRev7mREAsI9fxeK1&usqp=CAU"),
        ("Lasanha a bolonhesa","Lasanha a bolonhesa",6,"https://static.carrefour.com.br/imagens/chef-carrefour/imagem-receita/lasanha-a-bolonhesa.jpg"),
        ("Pizza de calabresa","Pizza feita com calabresa, molho de tomate e cebola",7,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTier13YV8zQMO01gFk-QgLqbZfAWhgMXL9UCCeC_U6DDluCDBY&usqp=CAU"),
        ("Pizza de frango com catupiry","Pizza feita com frango e catupiry",7,"https://s2.glbimg.com/ZBsYqDj_hRSeBwLhppilEg3JwfM=/696x390/smart/filters:cover():strip_icc()/s.glbimg.com/po/rc/media/2012/06/13/14/31/15/151/2607201005261284043239.jpg"),
        ("Pizza Portuguesa","Pizza portuguesa",7,"https://img.itdg.com.br/tdg/images/recipes/000/062/161/14806/14806_original.jpg?mode=crop&width=710&height=400"),
        ("Pizza 4 queijos","Pizza feita com 4 tipos de queijo",7,"https://img.cybercook.com.br/receitas/550/pizza-pan-4-queijos-2-623x350.png"),
        ("Chopp Bhrama","Copo de 900 ml de Chopp",8,"https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0R0f00000srGC2EAM/5c94cc58e4b0d52543352dd8.jpg&w=710&h=462"),
        ("Cerveja artesanal Musa","Garrafa de cerveja artesanal puro malte Musa",8,"https://www.lojinhauai.com/image/cache/catalog/Fotos/cerveja-artesanal-pilsen-puro-malte-musa-600x600.jpg"),
        ("Cerveja artesanal Bil Bil","Garrafa de cerveja artesanal Bil bil",8,"https://cdn.awsli.com.br/600x450/874/874479/produto/40947775/17757e888d.jpg"),
        ("Chopp Heineken","Caneca de 900 ml do chopp Heineken",8,"https://img.elo7.com.br/product/zoom/270BC13/caneca-chopp-bristol-heineken-barato.jpg"),
        ("Temaki","Temaki de kani",9,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRZd4LJ6WfWfTZCoeoufHxs0KfI_upyla-3HVuWuJnMsOsSvXdm&usqp=CAU"),
        ("Niguri","8 unidades de niguri de salmão",9,"https://cdn.neemo.com.br/uploads/item/photo/2405/prod15_original.jpg"),
        ("Sushi california hot holl","4 unidades de sushi empanado de salmão",9,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRcN4iceS3-9bVrj0hIAvmbTEA7s5lXXLB7Oj8U4Bqwyt7NDKYT&usqp=CAU"),
        ("Ceviche","Peixe cru com cebola roxa ao molho de pimenta e limão",9,"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQm4pvW2aoXGOg2_V03TDdrEqCXnGB6nVtVRT8TwSGGX8KkD72c&usqp=CAU");
    
    ''');

    await db.execute('''
                INSERT INTO Preco(preco,date,idPrato)
                VALUES(15.90, "2020-04-10 10:00:00", 1),
                (12.90, "2020-04-01 10:00:00", 2),
                (15.90, "2020-04-01 10:00:00", 3),
                (18.90, "2020-04-01 10:00:00", 4),
                (18.90, "2020-04-01 10:00:00", 5),
                (4.90, "2020-04-01 10:00:00", 6),
                (6.90, "2020-04-01 10:00:00", 7),
                (9.90, "2020-04-01 10:00:00", 8),
                (3.90, "2020-04-01 10:00:00", 9),
                (3.90, "2020-04-01 10:00:00", 10),
                (6.90, "2020-04-01 10:00:00", 10),
                (4.00, "2020-04-01 10:00:00", 11),
                (8.90, "2020-04-01 10:00:00", 12),
                (15.90, "2020-04-01 10:00:00", 13),
                (16.99, "2020-04-01 10:00:00", 14),
                (20.90, "2020-04-01 10:00:00", 15),
                (6.00, "2020-04-01 10:00:00", 16),
                (7.50, "2020-04-01 10:00:00", 17),
                (6.50, "2020-04-01 10:00:00", 18),
                (9.99, "2020-04-01 10:00:00", 19),
                (9.99, "2020-04-01 10:00:00", 20),
                (12.90, "2020-04-01 10:00:00", 21),
                (18.20, "2020-04-01 10:00:00", 22),
                (15.60, "2020-04-01 10:00:00", 23),
                (11.00, "2020-04-01 10:00:00", 24),
                (19.90, "2020-04-01 10:00:00", 25),
                (17.80, "2020-04-01 10:00:00", 26),
                (21.99, "2020-04-01 10:00:00", 27),
                (24.60, "2020-04-01 10:00:00", 28),
                (7.99, "2020-04-01 10:00:00", 29),
                (12.00, "2020-04-01 10:00:00", 30),
                (11.99, "2020-04-01 10:00:00", 31),
                (9.99, "2020-04-01 10:00:00", 32),
                (8.99, "2020-04-01 10:00:00", 33),
                (9.99, "2020-04-01 10:00:00", 34),
                (8.99, "2020-04-01 10:00:00", 35),
                (9.99, "2020-04-01 10:00:00", 36);

    ''');


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
      print(err);
      return false;
    }
  }

  Future<bool> savePedido(Pedido p, double preco) async {
    try {
      var dbClient = await db;
      await dbClient.rawInsert(
          '''INSERT INTO Pedidos(data, precoTotal, adress) VALUES(datetime('now','localtime'),?,?)''',
          [preco, p.adress]);
      dynamic pedido = await dbClient.rawQuery(
          'SELECT idPedido From Pedidos ORDER BY idPedido DESC LIMIT 1');
      print('p.prato->${p.prato.length}');
      int idPedido = pedido[0]['idPedido'];
      print('idpedido---->$idPedido');
      print('preco ---->${p.prato[0].preco.preco}');
      List<Prato> pratos = p.prato;
      List<int> qnt = p.qnt;
      print('${pratos.length}  ${qnt.length}');

      for (int i = 0; i < pratos.length; i++) {
        print('idprato --> ${pratos[i].idPrato}');
        await dbClient.rawInsert(
            'INSERT INTO PedidoPratoUser (idPrato, idUser, idPedido, quantidade, idPreco) VALUES(?,?,?,?,?)',
            [pratos[i].idPrato, p.user.id, idPedido, qnt[i], pratos[i].preco.id]);
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<void> updateEntrega(Restaurant res, int a) async {
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE Restaurant
      SET entregaGratis=?
      WHERE Restaurant.idRest=?
      ''', [a, res.id]);
    // res.setEntrega(a);
  }

  Future<void> changeNamePlate(int id, String name) async{
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE Prato
      SET name='$name'
      WHERE Prato.idPrato=$id
      ''');
  }

  Future<void> changeDescPlate(int id, String desc) async{
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE Prato
      SET descricao='$desc'
      WHERE Prato.idPrato=$id
      ''');
  }
  Future<void> changeImgPlate(int id, String img) async{
    var dbClient = await db;
    await dbClient.rawUpdate('''
      UPDATE Prato
      SET img='$img'
      WHERE Prato.idPrato=$id
      ''');
  }

  Future<void> saveCategoria(String name, String img, int id) async {
    var dbClient = await db;
    try{
     
     await dbClient.rawInsert(
        'INSERT INTO Categoria(name, image) VALUES(?,?)', [name, img]);
    dynamic t = await dbClient.rawQuery('''SELECT * FROM Categoria WHERE name='$name' '''); 
    await dbClient.rawInsert(
          'INSERT INTO CategoriaRest(idRest, idCategoria) VALUES(?,?)',
          [id, t[0]['idCategoria']]);
      
    }catch(e){
      print(e);
    }

  }

  Future<void> saveRelacionCatRest(int idRest, int idCat) async {
    var dbClient = await db;
    
    
      await dbClient.rawInsert(
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
    dynamic response = await dbClient.rawQuery(
        'SELECT Categoria.idCategoria , Categoria.image AS imageCategoria, Categoria.name AS nameCategoria FROM Categoria');
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
                Categoria.name as nameCategoria,
                Categoria.image as imageCategoria,
                Categoria.idCategoria 
          FROM 
                CategoriaRest INNER JOIN  Categoria ON Categoria.idCategoria = CategoriaRest.idCategoria 
          WHERE 
                CategoriaRest.idRest=?''', [idRest]);
    List<Categories> cat = List<Categories>();
    print(resp);
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
      rests.last.addPrato(Prato.mapJOIN(i));
      if (i['idRest'] == savedIdRest) {
        rests.removeLast();
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
            Preco.idPreco,
            Preco.*
      FROM 
            Restaurant LEFT JOIN CategoriaRest ON Restaurant.idRest = CategoriaRest.idRest
            LEFT JOIN Categoria ON CategoriaRest.idCategoria = Categoria.idCategoria
            LEFT JOIN Prato ON Restaurant.idRest = Prato.idRest
            LEFT JOIN Preco ON Prato.idPrato = Preco.idPrato
      WHERE 
            Restaurant.email=? and Restaurant.password=? 
      GROUP BY
            Categoria.idCategoria
    
            ''', [email, password]);
    try {
      print('login Rest --> $rest');
      Restaurant usual = Restaurant.map(rest[0]);
      if (rest[0]['idCategoria'] != null) {
        List<Categories> cat = new List<Categories>();
        for (Map i in rest) {
          cat.add(Categories.map(i));
        }
        usual.setCategories(cat);
      }
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
            Prato.idRest=? AND Prato.active=1
      GROUP BY Prato.idPrato
            ''', [idRest]);
    try {
      test[0];
      List<Prato> cardapio = new List<Prato>();
      for (var i in test) {
        print(i);
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
              Preco.*,
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

  Future<Pedido> getRelatorio1(int idRest) async {
    var dbClient = await this.db;
    List<Map> test = await dbClient.rawQuery('''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Pedidos.*,
            Preco.*,
            PedidoPratoUser.*,
            SUM(PedidoPratoUser.quantidade) AS qntPedidoPrato
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPrato = PedidoPratoUser.idPreco
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest
      GROUP BY
            Prato.idPrato
      ORDER BY 
            qntPedidoPrato DESC
      LIMIT 1
      ''');
    try {
      Pedido pedido = Pedido.map(test[0]);
      pedido.addPrato(Prato.mapJOIN(test[0]));
      pedido.addQnt(test[0]['qntPedidoPrato']);
      return pedido;
    } catch (err) {
      return null;
    }
  }

  Future<List<Pedido>> getRelatorio2_1day(int idRest) async {
    String date1 =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 = await dbClient.rawQuery('''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Pedidos.*,
            Preco.*,
            PedidoPratoUser.*
      FROM 
            Prato INNER JOIN PedidoPratoUser ON PedidoPratoUser.idPrato = Prato.idPrato
            INNER JOIN Preco ON Preco.idPreco = PedidoPratoUser.idPreco
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            Prato.idPrato, PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');

    Map<int, Pedido> map = new Map<int, Pedido>();

    for (var i in test1) {
      // print('$i\n\n\n');
      if (!map.containsKey(i['idPedido'])) {
        map[i['idPedido']] = Pedido.map(i);

        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      } else {
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      }
      print('maaap --> $map');
    }
    List<Pedido> pedidos = new List<Pedido>();
    map.forEach((k, v) => pedidos.add(v));
    return pedidos;
  }

  Future<List<Pedido>> getRelatorio2_7days(int idRest) async {
    String date1 =
        DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 = await dbClient.rawQuery('''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Pedidos.*,
            Preco.*,
            PedidoPratoUser.*
      FROM 
            Prato INNER JOIN PedidoPratoUser ON PedidoPratoUser.idPrato = Prato.idPrato
            INNER JOIN Preco ON Preco.idPreco = PedidoPratoUser.idPreco
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            Prato.idPrato, PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');
      
    Map<int, Pedido> map = new Map<int, Pedido>();

    for (var i in test1) {
      // print('$i\n\n\n');
      if (!map.containsKey(i['idPedido'])) {
        map[i['idPedido']] = Pedido.map(i);

        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      } else {
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      }
      print('maaap --> $map');
    }
    List<Pedido> pedidos = new List<Pedido>();
    map.forEach((k, v) => pedidos.add(v));
    return pedidos;
  }

  Future<List<Pedido>> getRelatiorio2_30days(int idRest) async {
    var dbClient = await this.db;
    String date15 =
        DateTime.now().subtract(Duration(days: 30)).toString().substring(0, 19);
    List<Map> test1 = await dbClient.rawQuery('''
      SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Pedidos.*,
            Preco.*,
            PedidoPratoUser.*
      FROM 
            Prato INNER JOIN PedidoPratoUser ON PedidoPratoUser.idPrato = Prato.idPrato
            INNER JOIN Preco ON Preco.idPreco = PedidoPratoUser.idPreco
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date15'
      GROUP BY
            Prato.idPrato, PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');
      
    Map<int, Pedido> map = new Map<int, Pedido>();

    for (var i in test1) {
      // print('$i\n\n\n');
      if (!map.containsKey(i['idPedido'])) {
        map[i['idPedido']] = Pedido.map(i);

        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      } else {
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      }
      print('maaap --> $map');
    }
    List<Pedido> pedidos = new List<Pedido>();
    map.forEach((k, v) => pedidos.add(v));
    return pedidos;
  }

  Future<List<Prato>> getRelatorio3(int idRest) async {
    String date1 =
        DateTime.now().subtract(Duration(days: 7)).toString().substring(0, 19);
    var dbClient = await this.db;
    List<Map> test1 = await dbClient.rawQuery('''
     SELECT
            Prato.idPrato,
            Prato.name AS namePrato,
            Prato.descricao AS descricaoPrato,
            Prato.img AS imgPrato,
            Restaurant.*,
            Preco.*,
            PedidoPratoUser.*,
            Pedidos.*,
            SUM(Preco.preco*PedidoPratoUser.quantidade) AS media,
            SUM(PedidoPratoUser.quantidade) as sumQnt
      FROM 
            PedidoPratoUser INNER JOIN Prato ON Prato.idPrato = PedidoPratoUser.idPrato
            INNER JOIN Preco ON Preco.idPreco = PedidoPratoUser.idPreco
            INNER JOIN Restaurant ON Restaurant.idRest = Prato.idRest
            INNER JOIN Pedidos ON Pedidos.idPedido = PedidoPratoUser.idPedido
      WHERE
            Restaurant.idRest=$idRest AND Pedidos.data>'$date1'
      GROUP BY
            Prato.idPrato
      ORDER BY Pedidos.data DESC
      ''');

    print(test1);



    Map<int, Prato> map = new Map<int, Prato>();
    for (var i in test1) {

      print('\n\n\n$i\n\n\n');

      if(!map.containsKey(i['idPrato'])) {
        map[i['idPrato']] = Prato.mapJOIN(i);
      }
    
      print('maaap --> $map');
    }
    List<Prato> pratos = new List<Prato>();


    map.forEach((k, v) => pratos.add(v));
    return pratos;
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
            Preco.*,
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
            INNER JOIN Preco on Preco.idPreco = PedidoPratoUser.idPreco
      WHERE
            Prato.idRest = $rest
      GROUP BY
            Prato.idPrato, PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');
    Map<int, Pedido> map = new Map<int, Pedido>();
    for (var i in test) {
      if (!map.containsKey(i['idPedido'])) {
        map[i['idPedido']] = Pedido.map(i);
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      } else {
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      }
      print('maaap --> $map');
    }
    List<Pedido> pedidos = new List<Pedido>();
    map.forEach((k, v) => pedidos.add(v));
    return pedidos;
  }

  Future<List<Restaurant>> getMaisPedidos() async {
    var dbClient = await this.db;
    String date =
        DateTime.now().subtract(Duration(days: 1)).toString().substring(0, 19);
    List<Map> test = await dbClient.rawQuery('''
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
            Restaurant.idRest
      ORDER BY 
            qntPedidoPrato DESC
      LIMIT 5
      ''');
    List<Restaurant> rests = transforming(test);
    return rests;
  }

  void deletePlate(int id)async{
   var dbClient = await db;
    dbClient.rawUpdate('''
        UPDATE Prato
        SET active=0
        WHERE Prato.idPrato = $id
        ''');

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
            Preco.*,
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
            INNER JOIN Preco on Preco.idPreco = PedidoPratoUser.idPreco
      WHERE 
            PedidoPratoUser.idUser = $idUser
      GROUP BY  
            Prato.idPrato, PedidoPratoUser.idPedido
      ORDER BY Pedidos.data DESC
      ''');

    print('test--> $test');
    Map<int, Pedido> map = new Map<int, Pedido>();
    for (var i in test) {
      if (!map.containsKey(i['idPedido'])) {
        map[i['idPedido']] = Pedido.map(i);
        map[i['idPedido']].addPrato(Prato.mapJOIN(i));
        map[i['idPedido']].addQnt(i['quantidade']);
      } else {
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