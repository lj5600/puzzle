import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldb/db.dart';
import 'package:sqldb/login.dart';
import 'package:sqldb/profile.dart';

import 'global.dart';
import 'homepage.dart';

void main(){
  runApp(MaterialApp(
    home: Welcome(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static List<Map> mm = [];
  static String worning = "";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Database db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabase();
    getallData();
  }

  TextEditingController conName = TextEditingController();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: 50,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: conName,
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: conEmail,
                decoration: InputDecoration(
                  errorText: HomePage.worning,
                  labelText: "Enter Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Colors.blue),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: conPass,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2,color: Colors.blue),
                  ),
                ),
              ),
            ),

            ElevatedButton(onPressed: () {

              String name = conName.text;
              String email = conEmail.text;
              String pass = conPass.text;

              Db().insertData(name, email, pass, db).then((value) {
                if(value){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("successful")));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Profile();
                  },));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("already exists account")));
                }
              });

            }, child: Text("submit")),

            SizedBox(height: 50,),

            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${HomePage.mm[index]['id']}"),
                  title: Text("${HomePage.mm[index]['name']}"),
                  subtitle: Text("${HomePage.mm[index]['email']}"),
                  trailing: Text("${HomePage.mm[index]['password']}"),
                );
              },
                itemCount: HomePage.mm.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDatabase() {
    Db().getDatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  void getallData() {
    Db().getDatabase().then((value) {
      setState(() {
        db = value;
      });

      Db().viewData(db!).then((value) {
        setState(() {
          HomePage.mm = value;
        });
      });
    });
  }


}
