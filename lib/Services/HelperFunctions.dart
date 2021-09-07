

import 'package:momusik/Services/Arguments.dart';
import 'package:momusik/Services/Data.dart';

class HelperFunction{

  //gets the file name of music track from its path
  String getRawFilename(String rawFileName){
    int index1 = rawFileName.lastIndexOf("/");
    int index2 = rawFileName.indexOf(".mp3");
    String rawRaw = rawFileName.substring(index1+1,index2);
    return rawRaw;
  }

  //gets the file name of music track from its path
  String getRawFileName2(String path,SecondArguments args,Data data){
    int index1 = args.musicFiles[data.selected].lastIndexOf("/");
    int index2 = args.musicFiles[data.selected].indexOf(".mp3");
    String rawRaw = args.musicFiles[data.selected].substring(index1 + 1, index2);
    return rawRaw;
  }
}