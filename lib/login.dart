import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldb/db.dart';
import 'package:sqldb/main.dart';
import 'package:sqldb/profile.dart';

class Login extends StatefulWidget {
  static Database? db;
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: conEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: conPass,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          ElevatedButton(onPressed: () {
            Db().loginUser(conEmail.text,conPass.text).then((value) {
              if(true){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Profile();
                },));
              }
            });
          }, child: Text("Login")),

          ElevatedButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            },));
          }, child: Text("Register")),
        ],
      ),
    );
  }

  void getdatabase() {
    Db().getDatabase().then((value){
      setState(() {
        Login.db = value;
      });
    });
  }
}
