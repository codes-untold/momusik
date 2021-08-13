import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class MusicPlayer{

  AudioPlayer advancedPlayer;
  AudioCache audioCache;


  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

}