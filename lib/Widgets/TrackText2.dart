import 'package:flutter/material.dart';

class TrackText2 extends StatelessWidget {

  final metaFiles;
  final currentNo;
  final rawFileString;
  final trackCount;

  TrackText2({this.metaFiles,this.currentNo,this.rawFileString,this.trackCount});

  @override
  Widget build(BuildContext context) {
    return Text(metaFiles[currentNo].trackArtistNames == null? "Unknown  .${trackCount.minute}"
        ": ${trackCount.second}": "${metaFiles[currentNo].trackArtistNames[0]} .${trackCount.minute} : ${trackCount.second}",
      style: TextStyle(
          color: Colors.white54,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          fontSize: 12.0
      ),);
  }
}
