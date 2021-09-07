import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:momusik/Services/HelperFunctions.dart';
import 'package:provider/provider.dart';
import '../Services/Arguments.dart';
import '../Services/CounterText.dart';
import '../Services/Data.dart';
import '../constants/constants.dart';


class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioCache audioCache = AudioCache();
  Data data;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
      final SecondArguments args = ModalRoute.of(context).settings.arguments;
      initPlayer(args);
    });

  }

   //handles operations when play or pause button is clicked
  void playButton(SecondArguments args) {
    if (data.playing == false) {
      setState(() {
        args.audioPlayer.play(args.musicFiles[data.selected], isLocal: true);
        data.changeState();
      });
    }

    else {
      args.audioPlayer.pause();
      setState(() {
        data.changeState();
      });
    }
  }

  //handles operation when the next button is clicked
  void nextButton(SecondArguments args) {
    data.updateStateToPlaying();   //sets playing state to true

    if (data.selected == args.musicFiles.length - 1) {
          return;
    }
    else {
      setState(() {
        args.audioPlayer.stop();
        data.nextWave();         //moves to next track
        args.audioPlayer.play(args.musicFiles[data.selected], isLocal: true);
      });
    }
  }

  void previousButton(SecondArguments args) {
    data.updateStateToPlaying();      //sets playing state to true
    if (data.selected == 0) {
          return;
    }
    else {
      setState(() {
        args.audioPlayer.stop();
        data.previousWave();          //moves to previous track
        args.audioPlayer.play(args.musicFiles[data.selected], isLocal: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   data = Provider.of<Data>(context,listen: false);
    SecondArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            left: 10.0, right: 10, top: 75.0, bottom: 10.0),
        decoration: gradient_color,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(

          children: [
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 75.0,
                    backgroundImage: AssetImage('images/moimage.png'),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    child: Text(args.metaFiles[data.selected].trackName == null?
                    HelperFunction().getRawFileName2(args.musicFiles[data.selected],args,data) : args.metaFiles[data.selected].trackName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(args.metaFiles[data.selected].trackArtistNames == null ? "Unknown"
                        : args.metaFiles[data.selected].trackArtistNames[0],
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],

              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(child: CounterText(value: _position.inSeconds,),
                        flex: 1,),
                      Expanded(
                        child: Slider(
                          value: _position.inSeconds.toDouble(),
                          activeColor: Colors.pinkAccent,
                          inactiveColor: Colors.grey,
                          onChanged: (double value) {
                            setState(() {
                              seekToSecond(value.roundToDouble().toInt(),args);
                              value = value;
                            });
                          },
                          min: 0.0,
                          max: _duration.inSeconds.toDouble()>_position.inSeconds.toDouble()?
                          _duration.inSeconds.toDouble():_position.inSeconds.toDouble(),

                        ),
                        flex: 7,),
                      Expanded(child: CounterText(value: _duration.inSeconds ,),
                        flex: 1,),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Flexible(

                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.shuffle,
                            color: Colors.white,),
                          onPressed: null,
                        ),

                        IconButton(
                          icon: Icon(Icons.fast_rewind,
                            color: Colors.white,),
                          onPressed: () {
                            previousButton(args);
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30.0)),
                              color: Colors.pinkAccent,
                              boxShadow: [BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 10.0,
                                spreadRadius: 0.0,


                              )
                              ]
                          ),
                          child: Consumer<Data>(
                            builder: (__,providerData,_){
                              return IconButton(
                                icon: Icon(providerData.playing?Icons.pause:Icons.play_arrow),
                                color: Colors.white,
                                onPressed: () {
                                  playButton(args);

                                },);
                            },
                          ),

                        ),
                        IconButton(
                          icon: Icon(Icons.fast_forward,
                            color: Colors.white,),
                          onPressed: () {
                            nextButton(args);
                          },
                        ),

                        Consumer<Data>(
                          builder: (context,providerData,_){
                            return IconButton(
                              icon: Icon(providerData.repeat?Icons.repeat_one:Icons.repeat,
                                color: Colors.white,),
                              onPressed: () {
                                providerData.changeRepeat();  //sets track repeat state to true or false
                              },
                            );
                          },

                        ),

                      ],),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //updates slider as tracks plays
  void seekToSecond(int second,SecondArguments args) {
    Duration newDuration = Duration(seconds: second);
    args.audioPlayer.seek(newDuration);

  }


  void initPlayer(SecondArguments args) {
    audioCache = new AudioCache(fixedPlayer: args.audioPlayer);
    args.audioPlayer.onDurationChanged.listen((event) {
      if(mounted){
        setState(() {
          _duration = event;
        });
      }
      else{
        return;
      }
    }
    );
    //listens for change in audio position in music track
    args.audioPlayer.onAudioPositionChanged.listen((event) {
      if(mounted){
        setState(() {
          _position = event;
        });
      }
      else{
        return;
      }
    });

      //handles operation when music track finish playing
    args.audioPlayer.onPlayerCompletion.listen((event) {
      if(mounted){
        if(data.repeat == true){
          setState(() {
            _position = Duration(seconds: 0);
            args.audioPlayer.seek(_position);
            args.audioPlayer.play(args.musicFiles[data.selected], isLocal: true);
          });
        }
        else{
          setState(() {
            nextButton(args);
          });
        }
      }
      else{
        if(data.repeat == true){
          _position = Duration(seconds: 0);
          args.audioPlayer.seek(_position);
          args.audioPlayer.play(args.musicFiles[data.selected], isLocal: true);
        }
        else{
          if (data.selected == args.musicFiles.length - 1) {
          }
          else {
            args.audioPlayer.stop();
          }
        }
      }
    });
  }


}