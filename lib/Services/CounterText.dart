import 'package:flutter/material.dart';

class CounterText extends StatefulWidget {

  final value;
  CounterText({this.value});

  @override
  _CounterTextState createState() => _CounterTextState();
}

class _CounterTextState extends State<CounterText> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    int minute = (widget.value/60).floor();
    int second = widget.value % 60;
    String secondCheck = (second.toString().length == 1)?'0$second': second.toString();

    return Text('$minute:$secondCheck',
      style: TextStyle(
          color: Colors.white
      ),);
  }

}