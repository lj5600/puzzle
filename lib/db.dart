import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldb/main.dart';

import 'global.dart';
import 'login.dart';

class Db {

  Future<Database>getDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath , 'MyDb.db');

    Database database = await openDatabase(path,version: 1,onCreate: (Database db,int version) async {
      await db.execute(
        'create table student (id integer primary key autoincrement, name Text, email Text, password Text)'
      );
    });
    return database;
  }

  Future<bool> insertData(String name, String email, String pass, Database db) async {

    String check = "select * from student where email = '$email' or password = '$pass'";
    List<Map> list1 = await db.rawQuery(check);

    if(list1.length == 1){

      return false;
    }
    else{
      String insertQry = "insert into student (name,email,password) values ('$name','$email','$pass')";
      int a = await db.rawInsert(insertQry);

      Global.pref.setString('name', name);
      Global.pref.setString('email', email);
      Global.pref.setString('pass', pass);
      Global.pref.setBool('check', true);

      print(a);

      return true;
    }
  }

  Future<List<Map>> viewData(Database database) async {
    String viewQuery = "select * from student";
    List<Map> list = await database.rawQuery(viewQuery);
    print(list);
    return list;
  }

  Future<bool> loginUser(String email, String pass) async {
    Database database = Login.db!;
    String selectQry = "select * from student where email = '$email' and password = '$pass'";

    List<Map> list = await database.rawQuery(selectQry);

    if(list.length == 0){
      print("try later");
      return false;
    }
    else{
      print("=====success $list");
      Global.pref.setBool('check', true);
      return true;
    }

  }
}