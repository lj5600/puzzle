import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqldb/login.dart';
import 'package:sqldb/profile.dart';

import 'global.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  String name = "";
  String email = "";
  String pass = "";
  bool check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shrepref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if(check == true){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              },));
            }
            else{
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login();
              },));
            }
          },
          child: Text("welcome"),
        ),
      ),
    );
  }

  Future<void> shrepref() async {
    Global.pref = await SharedPreferences.getInstance();
    setState(() {
      name = Global.pref.getString('name')??"name";
      email = Global.pref.getString('email')??"email";
      pass = Global.pref.getString('pass')??"pass";
      check = Global.pref.getBool('check')??false;
    });
  }
}
