import 'package:project_bd/Model/categories.dart';
import 'package:project_bd/Model/restaurant.dart';
import 'package:project_bd/Model/user.dart';
import 'package:project_bd/data/database.dart';

class Control{

  final DatabaseHelper _db = DatabaseHelper.internal();

  static final Control _instance = new Control.internal();
  factory Control() => _instance;
  Control.internal();
  
  Future<User> doLogin(String email, String password) async{
    User user = await this._db.getUser(email, password);
    return user;
  }

  Future<Restaurant> doLoginRestaurant(String name, String password) async{
    Restaurant rest = await this._db.getRestLogin(name, password);
    return rest;
  }

  Future<bool> saveUser(User u) async{
      return await this._db.saveUser(u);
  }

  Future<bool> saveRest( Restaurant rest) async{
    return await this._db.saveRest(rest);
  }

  Future<List<Categories>> getAllCategories() async{
    List<Categories> listCategories = await this._db.getAllCategories();
    return listCategories;
  }
  
  


}