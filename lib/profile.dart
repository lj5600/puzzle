import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqldb/login.dart';

import 'db.dart';
import 'global.dart';
import 'main.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = "";
  String email = "";
  String number = "";
  String gender = "";
  String city = "";
  Database? db;
  List<Map> list = [];

  TextEditingController conNum = TextEditingController();
  TextEditingController conGen = TextEditingController();
  TextEditingController conCity = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    sherpref();
    getallData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: conNum,
                    decoration: InputDecoration(
                      labelText: "Enter number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: conGen,
                    decoration: InputDecoration(
                      labelText: "Enter number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: conCity,
                    decoration: InputDecoration(
                      labelText: "Enter number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                TextButton(onPressed: () {

                  Navigator.pop(context);
                }, child: Text("ok")),
              ],
            );
          },);
        },
        child: Icon(CupertinoIcons.plus),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
             Center(child: Text(name)),
              Center(child: Text(email)),
              Center(child: Text(number)),
              Center(child: Text(gender)),
              Center(child: Text(city)),

              ElevatedButton(onPressed: () {
                Global.pref.setBool('check', false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Login();
                },));
              }, child: Text("logout")),
            ],
          ),
        ),
      ),
    );
  }

  void sherpref() {
    setState(() {
      name = Global.pref.getString('name')??"name";
      email = Global.pref.getString('email')??"email";
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
