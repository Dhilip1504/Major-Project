import 'package:flutter/material.dart';
import 'package:majorproject/pages/Question.dart';
import 'package:majorproject/pages/QuestionWidget.dart';

class Result extends StatefulWidget {
  final List<Question> qlist;
  final int score;
  final Color color1;
  final Color color2;
  final Color color3;
  final String title;
  final List<int> answ;
  const Result({Key key, this.qlist, this.color1, this.color2, this.color3, this.title, this.answ, this.score}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  Widget build(BuildContext context) {

    List<Question> qlist = widget.qlist;
    Color color1=widget.color1, color2=widget.color2, color3=widget.color3;
    String title = widget.title;

    List widgetList = [0,1,2,3].map((e) {
      return ResultCard(question: qlist[e],color1: color1,color2: color2, key:UniqueKey(),answ: widget.answ[e],);
    }).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Results"),
          elevation: 4.0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(
                children: [
                  SizedBox(height: 15.0,),
                  Text("Your Score is ${widget.score}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Column(
                    children: widgetList,
                  ),
                  SizedBox(height: 20.0)
                ],
              )
          ),
        )
    );
  }
}

class ResultCard extends StatelessWidget {
  final Question question;
  final Color color1;
  final Color color2;
  final int answ;
  const ResultCard({Key key, @required this.question, this.color1, this.color2, this.answ}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget result;

    if(answ == question.answer){
      result = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
          ),
          Text("   Answer is Correct", style: TextStyle(fontSize: 13.0),),
        ],
      );
    }
    else{
      String correct_ans;
      switch(question.answer){
        case 1:
          correct_ans = question.opA;
          break;
        case 2:
          correct_ans = question.opB;
          break;
        case 3:
          correct_ans = question.opC;
          break;
      }
      result = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.close,
            color: Colors.red,
          ),
          Text("   Correct Answer is " + correct_ans, style: TextStyle(fontSize: 13.0),),
        ],
      );
    }

    return Container(
      height: 240.0,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: color1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.id.toString()+".  "+question.quest,
            style: TextStyle(fontSize: 13.0),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 1,
                  activeColor: color2,
                  groupValue: answ,
                  toggleable: true,
              ),
              Text("   " + question.opA),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 2,
                  activeColor: color2,
                  groupValue: answ,
                  toggleable: true,
                  ),
              Text("   " + question.opB),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 3,
                  activeColor: color2,
                  groupValue: answ,
                  toggleable: true,
                  ),
              Text("   " + question.opC,),
            ],
          ),
          SizedBox(height: 10.0,),
          result,
        ],
      ),
    );
  }
}

