import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {


  bool playing = false;
  int selected = 0;
  bool repeat = false;


  void changeState() {
    if (playing == false) {
      playing = true;
    }
    else {
      playing = false;
    }
    notifyListeners();
  }

  void updateStateToPlaying() {
    playing = true;
    notifyListeners();
  }

  void nextWave(){
    selected++;
    notifyListeners();
  }

  void previousWave(){
    selected--;
    notifyListeners();
  }


  void changeRepeat(){
    if(repeat == true){
      repeat = false;
    }
    else{
      repeat = true;
    }
    notifyListeners();
  }

}