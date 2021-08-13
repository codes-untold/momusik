import 'dart:math';
class Method{

  String work(String rawFileName){
    int index1 = rawFileName.lastIndexOf("/");
    int index2 = rawFileName.indexOf(".mp3");
    String rawRaw = rawFileName.substring(index1+1,index2);
    return rawRaw;
  }

  int dowork(List<String> list){
    return Random().nextInt(list.length- 1);

  }
}