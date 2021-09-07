import 'package:flutter/material.dart';

class TrackText extends StatelessWidget {

  final metafiles;
  final currentNo;
  final rawFileString;

  TrackText({this.metafiles,this.currentNo,this.rawFileString});

  @override
  Widget build(BuildContext context) {
    return Text(metafiles[currentNo].trackName == null? rawFileString: metafiles[currentNo].trackName.length >25
        ?"${metafiles[currentNo].trackName.substring(0,23)}... ": metafiles[currentNo].trackName ,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),);
  }
}
