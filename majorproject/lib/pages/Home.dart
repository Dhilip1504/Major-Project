import 'package:flutter/material.dart';
import 'package:majorproject/pages/Question.dart';
import 'package:majorproject/pages/QuestionWidget.dart';
import 'package:majorproject/pages/Result.dart';
import 'package:majorproject/pages/loginandsignup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final String uname;
  final String pword;
  final SharedPreferences prefs;
  const Home({Key key, this.uname, this.pword, this.prefs}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String title = "Politics";
  List<int> score = [0,0,0,0];
  List<int> ans = [0,0,0,0];

  void setScore(int pos,int val, int answ){
    score[pos] = val;
    ans[pos] = answ;
  }

  Future<void> clearData(BuildContext context) async{
    SharedPreferences prefs = widget.prefs;
    await prefs.remove("log");
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => LoginAndSignup(prefs: prefs),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Question> qlist = [];
    Color color1, color2, color3;

    switch (title) {
      case "Politics":
        qlist.add(Question(1,
            "Who is the President of India?",
            "Pranab Mukherjee",
            "Ramnath Kovind",
            "Venkaiah Naidu", 2));
        qlist.add(Question(2,
            "Who is the Vice-President of India?",
            "Pranab Mukherjee",
            "Ramnath Kovind",
            "Venkaiah Naidu", 3));
        qlist.add(Question(3,
            "Who is the Prime Minister of India?",
            "Narendra Modi",
            "Manmohan Singh",
            "Rahul Gandhi",1));
        qlist.add(Question(4,
            "Who is the Tamilnadu's Cheif Minister?",
            "K Palanisamy",
            "M.K Stalin",
            "J Jeyalalitha", 2));
        color1 = Color(0xffffeada);
        color2 = Color(0xffd7a539);
        color3 = Color(0xffffc344);
        break;
      case "Sports":
        qlist.add(Question(1,
            "Captain of Indian Cricket Team",
            "Virat Kohli",
            "M.S Dhoni",
            "Rohit Sharma", 1));
        qlist.add(Question(2,
            "First Batsman to Reach 100 centuries",
            "Sachin Tendulkar",
            "Brian Lara",
            "Virat Kohli", 1));
        qlist.add(Question(3,
            "Current ICC World cup holder",
            "Australia",
            "India",
            "England", 3));
        qlist.add(Question(4,
            "Indian Hockey Team Captain",
            "Mandeep Singh",
            "Manpreet Singh",
            "P.R Sreejesh", 2));
        color1 = Color(0xffedffca);
        color2 = Color(0xffa6d749);
        color3 = Color(0xffa7ef23);
        break;
      case "Science":
        qlist.add(Question(1,
            "No. of bones in Human body",
            "207",
            "203",
            "206", 3));
        qlist.add(Question(2,
            "Largest Planet in Solar system",
            "Jupiter",
            "Saturn",
            "Venus", 1));
        qlist.add(Question(3,
            "No. of Teeth in Adult Human",
            "32",
            "33",
            "34", 1));
        qlist.add(Question(4,
            "Main gas on Earth's atmosphere",
            "Oxygen",
            "Nitrogen",
            "Carbon di-oxide", 2));
        color1 = Color(0xffcafdff);
        color2 = Color(0xff42b5ba);
        color3 = Color(0xff20f0f8);
    }

    List widgetList = qlist.map((e) {
      return QuestionWidget(question: e,color1: color1,color2: color2, key:UniqueKey(), setScore: setScore,);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20.0,35.0,20.0,20.0),
                width: double.maxFinite,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Color(0xFFFFD7D7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        widget.uname,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ),
            Divider(thickness: 1.0,),
            ListTile(
              onTap: (){
                if(title != "Politics") {
                  setState(() {
                    title = "Politics";
                  });
                }
                Navigator.pop(context);
              },
              title: Text("Politics", style: TextStyle(fontSize: 15.0),),
              leading: Text("P",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold
                ),),

            ),
            ListTile(
              onTap: (){
                if(title != "Sports") {
                  setState(() {
                    title = "Sports";
                  });
                }
                Navigator.pop(context);
              },
              title: Text("Sports", style: TextStyle(fontSize: 15.0),),
              leading: Text("S",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold
                ),),

            ),
            ListTile(
              onTap: (){
                if(title != "Science") {
                  setState(() {
                    title = "Science";
                  });
                }
                Navigator.pop(context);
              },
              title: Text("Science", style: TextStyle(fontSize: 15.0),),
              leading: Text("Sc",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold
                ),),

            ),
            Divider(thickness: 1.0,),
            ListTile(
              onTap: (){
                clearData(context);
              },
              title: Text("Log Out", style: TextStyle(fontSize: 15.0),),
              leading: Icon(Icons.logout,)

            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Column(
                children: widgetList,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0,top:20.0),
                height: 60.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FlatButton(
                    minWidth: double.maxFinite,
                    height: double.maxFinite,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Result(
                          qlist: qlist,
                          color3: color3,
                          color2: color2,
                          color1: color1,
                          title: title,
                          score: score[0]+score[1]+score[2]+score[3],
                          answ: ans,
                        ),
                      ));
                      print(score[0]+score[1]+score[2]+score[3]);
                    },
                    color: color3,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
