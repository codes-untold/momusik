import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {


  bool playing = false;
  int selected;
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

  void changeWave(int number){
    selected = number;
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