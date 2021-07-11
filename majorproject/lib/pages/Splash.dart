import 'dart:io';
import 'package:flutter/material.dart';
import 'package:majorproject/pages/loginandsignup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:majorproject/pages/Home.dart';

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String uname,pword;
    int log;

    Future<void> getUserSF() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uname = await prefs.getString('username');
      pword = await prefs.getString('password');
      log = await prefs.getInt('log') ?? 0;
      if(uname == null || log==0){
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginAndSignup(prefs: prefs,),
        ));
      }
      else{
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home(uname: uname, pword: pword, prefs: prefs,),
        ));
      }
    }

    getUserSF();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/quiz.png'), height: 200.0,),
            SizedBox(height: 30.0,),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
