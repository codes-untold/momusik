import 'package:flutter/material.dart';

class CounterText extends StatelessWidget {



  int value;
  CounterText({this.value});
  @override
  Widget build(BuildContext context) {

    int minute = (value/60).floor();
    int second = value%60;

    String second_check =  (second.toString().length == 1)?'0$second': second.toString();

    return Text('$minute:$second_check',
      style: TextStyle(
          color: Colors.white
      ),);
  }


}