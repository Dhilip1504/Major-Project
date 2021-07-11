import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:majorproject/pages/Home.dart';
import 'package:majorproject/pages/loginandsignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _moveAnimation;
  TextEditingController u_controller = TextEditingController();
  TextEditingController p_controller = TextEditingController();

  Future<void> setUserSF(BuildContext context, String u_name, String p_word) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', u_name);
    await prefs.setString('password', p_word);
    await prefs.setInt('log', 1);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Home(uname: u_name, pword: p_word, prefs: prefs),
    ));
  }

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _moveAnimation = Tween<double>(begin: 10.0, end: 50.0).animate(_controller);

    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                color: Color(0xffbdfffb),
              ),
            ),
            SizedBox(height: 20.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, _){
                    return Container(
                      height: 230,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: _moveAnimation.value),
                      child: Image(image: AssetImage('assets/Genie.png'), height: 180),
                    );
                  },
                ),
                SizedBox(height: 20.0,),
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
                      prefixIcon: Icon(Icons.person, color: Color(0xff27a8bf),),
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
                      prefixIcon: Icon(Icons.lock, color: Color(0xff27a8bf),),
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
                        else if(p_word.length < 6){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Password should be atleast of length 6"),
                          ));
                        }
                        else {
                          setUserSF(context, u_name, p_word);
                        }
                      },
                      color: Color(0xff27a8bf),
                      child: Text(
                        "SIGNUP",
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
                        "Already have an account?  ",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => LoginAndSignup(),
                          ));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Color(0xff27a8bf), fontSize: 14.0),
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
        color: Color(0xffdafffa),
      ),
      child: child,
    );
  }
}
