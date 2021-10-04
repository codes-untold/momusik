import 'package:flutter/material.dart';

class BottomBarText extends StatelessWidget {

  final metaFiles;
  final currentNo;
  final rawFileString;

  BottomBarText({this.metaFiles,this.currentNo,this.rawFileString});


  @override
  Widget build(BuildContext context) {
    return Text(metaFiles[currentNo].trackName == null? rawFileString.toString().length>25?
    "${rawFileString.toString().substring(0,15)}...": rawFileString
        : metaFiles[currentNo].trackName.length>25
        ?"${metaFiles[currentNo].trackName.substring(0,15)}... ": metaFiles[currentNo].trackName,

      style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 15.0,
          color: Colors.white70
      ),);
  }
}
