import 'package:flutter/material.dart';
import 'package:majorproject/pages/Question.dart';

class QuestionWidget extends StatefulWidget {

  final Question question;
  final Color color1;
  final Color color2;
  final CallBack setScore;

  const QuestionWidget({Key key, @required this.question, this.color1, this.color2, this.setScore}) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {

  int selectedRadio=0;
  setSelectedRadio(val){
    setState(() {
      selectedRadio = val;
    });
    if(val == widget.question.answer){
      widget.setScore(widget.question.id-1, 1, val);
    }
    else{
      widget.setScore(widget.question.id-1,0, val);
    }
  }

  @override
  void initState() {
    widget.setScore(widget.question.id-1, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200.0,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      padding: EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: widget.color1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              widget.question.id.toString()+".  "+widget.question.quest,
            style: TextStyle(fontSize: 13.0),
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 1,
                  activeColor: widget.color2,
                  groupValue: selectedRadio,
                  toggleable: true,
                  onChanged: (val){
                    setSelectedRadio(val);
                    //print(val);
                  }),
              Text("   " + widget.question.opA),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 2,
                  activeColor: widget.color2,
                  groupValue: selectedRadio,
                  toggleable: true,
                  onChanged: (val){
                    //print(val);
                    setSelectedRadio(val);
                  }),
              Text("   " + widget.question.opB),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(value: 3,
                  activeColor: widget.color2,
                  groupValue: selectedRadio,
                  toggleable: true,
                  onChanged: (val){
                    //print(val);
                    setSelectedRadio(val);
                  }),
              Text("   " + widget.question.opC),
            ],
          )
        ],
      ),
    );
  }
}

typedef CallBack = void Function(int pos, int val, int answ);
