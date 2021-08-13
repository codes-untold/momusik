class TrackDuration{

  String minute;
  String second;
  Duration duration = Duration();


  void changeDuration (int time){
    Duration duration = Duration(milliseconds: time);

    minute = duration.inMinutes.toString();
    second = (duration.inSeconds - (duration.inMinutes * 60)).toString();


    if(second.length == 1){
      second = "0$second";

    }
    else{
      second = second;
    }

  }
}