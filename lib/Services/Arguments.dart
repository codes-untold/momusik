import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class ScreenArguments{

  final List<String> list;

  ScreenArguments({this.list});
}


class SecondArguments{

  List <Metadata> metaFiles;
  List <Uint8List> albumArtFiles;
  List <String> musicFiles;
  int currentFile;
  AudioPlayer audioPlayer;


  SecondArguments({this.musicFiles,this.metaFiles,this.currentFile,this.albumArtFiles,this.audioPlayer});
}

class ThirdArguments{

  AudioPlayer audioPlayer;

  ThirdArguments({this.audioPlayer});
}