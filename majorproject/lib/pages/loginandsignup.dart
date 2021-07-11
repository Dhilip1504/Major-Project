import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majorproject/pages/Home.dart';
import 'package:majorproject/pages/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndSignup extends StatefulWidget {
  final SharedPreferences prefs;
  const LoginAndSignup({Key key, this.prefs}) : super(key: key);

  @override
  _LoginAndSignupState createState() => _LoginAndSignupState();
}

class _LoginAndSignupState extends State<LoginAndSignup> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  TextEditingController u_controller = TextEditingController();
  TextEditingController p_controller = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(seconds: 5), vsync: this)..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> checkUserSF(BuildContext context, String u_name, String p_word) async{
    SharedPreferences prefs = widget.prefs;
    String u = await prefs.getString('username') ?? "";
    String p = await prefs.getString('password') ?? "";
    if(u != u_name){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Wrong username"),
      ));
      u_controller.clear();
      p_controller.clear();
    }
    else if(p != p_word){
      print(p);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Wrong Password"),
      ));
      p_controller.clear();
    }
    else {
      await prefs.setInt('log', 1);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home(uname: u_name, pword: p_word, prefs: prefs),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110.0,
              height: 110.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(110.0)),
                color: Color(0xffffdf9c),
              ),
            ),
            SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    child: Image(image: AssetImage('assets/sun.png'), height: 150.0),
                  animation: _controller,
                  builder: (_, child){
                      return Transform.rotate(
                        angle: _controller.value*2* 3.14159265358979323846,
                        child: child,
                      );
                  },
                ),
                SizedBox(height: 40.0,),
                TextFieldContainer(
                  child: TextField(
                    controller: u_controller,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.person, color: Color(0xffe7a500),),
                      hintText: "Username",
                    ),
                  ),
                  margin: 40.0,
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: p_controller,
                    obscureText: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.lock, color: Color(0xffe7a500),),
                      hintText: "Password",
                    ),
                  ),
                  margin: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                  height: 60.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: FlatButton(
                      minWidth: double.maxFinite,
                      height: double.maxFinite,
                      onPressed: (){
                        String u_name = u_controller.text.toString();
                        String p_word = p_controller.text.toString();
                        if(u_name.length < 1){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter username"),
                          ));
                        }
                        else if(p_word.length < 1){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Enter Password"),
                          ));
                        }
                        else {
                          checkUserSF(context, u_name, p_word);
                        }
                      },
                      color: Color(0xffffc344),
                      child: Text(
                          "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignUp()
                          ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Color(0xffcd9b32), fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double margin;
  const TextFieldContainer({Key key, this.child, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      margin: EdgeInsets.only(left: margin, right: margin, bottom: 20.0),
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.0),
        color: Color(0xffffecbe),
      ),
      child: child,
    );
  }
}

