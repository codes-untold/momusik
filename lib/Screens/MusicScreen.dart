import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
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
  IconData icon;
  int currentFile;
  bool repeat;


  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      final SecondArguments args = ModalRoute.of(context).settings.arguments;
      initPlayer(args);
    });

  }

  void repeatButton(){
    if(repeat == true){
      repeat = false;
    }
    else{
      repeat = true;
    }
  }


  void playButton(SecondArguments args) {

    if (Provider.of<Data>(context).playing == false) {
      setState(() {
        args.audioPlayer.play(args.musicFiles[Provider.of<Data>(context).selected], isLocal: true);
        icon = Icons.pause;
        Provider.of<Data>(context).changeState();
      });
    }
    else {

      args.audioPlayer.pause();
      setState(() {
        icon = Icons.play_arrow;
        Provider.of<Data>(context).changeState();
      });
    }
  }

  void nextButton(SecondArguments args) {

    if ( Provider.of<Data>(context).selected == args.musicFiles.length - 1) {

    }

    else {
      setState(() {
        args.audioPlayer.stop();
        icon = Icons.pause;
        Provider.of<Data>(context).nextWave();
        currentFile = Provider.of<Data>(context).selected;
        args.audioPlayer.play(args.musicFiles[Provider.of<Data>(context).selected], isLocal: true);
      });
    }
  }

  void previousButton(SecondArguments args) {
    if (Provider.of<Data>(context).selected == 0) {

    }

    else {
      setState(() {
        args.audioPlayer.stop();
        icon = Icons.pause;
        Provider.of<Data>(context).previousWave();
        currentFile = Provider.of<Data>(context).selected;
        args.audioPlayer.play(args.musicFiles[Provider.of<Data>(context).selected], isLocal: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SecondArguments args = ModalRoute.of(context).settings.arguments;
    currentFile = Provider.of<Data>(context).selected;
    repeat = Provider.of<Data>(context).repeat;

    icon = Provider.of<Data>(context).playing? Icons.pause: Icons.play_arrow;
    int index1 = args.musicFiles[Provider.of<Data>(context).selected].lastIndexOf("/");
    int index2 = args.musicFiles[Provider.of<Data>(context).selected].indexOf(".mp3");
    String rawRaw = args.musicFiles[Provider.of<Data>(context).selected].substring(
        index1 + 1, index2);

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context,currentFile);
        return false;
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              left: 10.0, right: 10, top: 75.0, bottom: 10.0),
          decoration: gradient_color,
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
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
                      child: Text(args.metaFiles[Provider.of<Data>(context).selected].trackName == null ?
                      rawRaw : args.metaFiles[Provider.of<Data>(context).selected].trackName,
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
                    Text(
                      args.metaFiles[Provider.of<Data>(context).selected].trackArtistNames == null
                          ?
                      "Unknown"
                          : args.metaFiles[Provider.of<Data>(context).selected]
                          .trackArtistNames[0],
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                      ),),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
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
                            onPressed: () {
                            },
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
                            child: IconButton(icon: Icon(icon),
                              color: Colors.white,
                              onPressed: () {
                                playButton(args);

                              },),

                          ),
                          IconButton(
                            icon: Icon(Icons.fast_forward,
                              color: Colors.white,),
                            onPressed: () {
                              nextButton(args);
                            },
                          ),

                          IconButton(
                            icon: Icon(Provider.of<Data>(context).repeat?Icons.repeat_one:Icons.repeat,
                              color: Colors.white,),
                            onPressed: () {
                              Provider.of<Data>(context).changeRepeat();
                              repeatButton();
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
      ),
    );
  }

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


    args.audioPlayer.onPlayerCompletion.listen((event) {
      if(mounted){
        if(repeat == true){
          setState(() {
            _position = Duration(seconds: 0);
            args.audioPlayer.seek(_position);
            args.audioPlayer.play(args.musicFiles[currentFile], isLocal: true);
          });
        }
        else{
          setState(() {
            nextButton(args);
          });
        }
      }
      else{
        if(repeat == true){
          _position = Duration(seconds: 0);
          args.audioPlayer.seek(_position);
          args.audioPlayer.play(args.musicFiles[currentFile], isLocal: true);
        }
        else{
          if (currentFile == args.musicFiles.length - 1) {
          }
          else {
            args.audioPlayer.stop();
            icon = Icons.play_arrow;
            //  currentFile++;
            //args.audioPlayer.play(args.musicFiles[currentFile], isLocal: true);
          }
        }
      }
    });
  }
}