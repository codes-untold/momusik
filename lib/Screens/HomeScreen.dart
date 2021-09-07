import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:momusik/Widgets/HeaderWidget.dart';
import 'package:momusik/Widgets/MusicList.dart';
import 'package:provider/provider.dart';
import 'package:move_to_background/move_to_background.dart';

import '../Services/Arguments.dart';
import '../Services/Data.dart';
import '../Services/MetaData.dart';
import '../constants/constants.dart';


class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  ScreenArguments args;
  List <Metadata> metaFiles = [];
  static List <String> musicFiles = [];
  AudioPlayer audioPlayer = AudioPlayer();
  MetaDataWork metaDataWork = MetaDataWork();
  Data provider;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    provider = Provider.of<Data>(context,listen: false);
    return WillPopScope(
      onWillPop: ()async{
        if(provider.playing){
          MoveToBackground.moveTaskToBack(); //minimize app if track is currently playing
          return false;
        }else{
          return true;
        }

      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: gradient_color,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      HeaderWidget(),
                      FutureBuilder(
                        future: fetchData(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            return musicFiles.isNotEmpty? MusicList(metaFiles: metaFiles,
                              musicFiles: musicFiles,
                              audioPlayer: audioPlayer,):
                            Container(
                              height: MediaQuery.of(context).size.height* 0.5,
                              width: MediaQuery.of(context).size.width *0.8,
                              child: Center(
                                  child: Text("Couldn't fetch music files"
                                    ,style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.white
                                    ),
                                    textAlign: TextAlign.center,)
                              ),
                            );
                          }
                          else
                          if(snapshot.hasError){
                            throw snapshot.error;
                          }
                          else{
                            return Container(
                              height: MediaQuery.of(context).size.height* 0.5,
                              width: MediaQuery.of(context).size.width *0.8,
                              child: Center(
                                child: SpinKitCircle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                        },
                      ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  //fetches and returns metadata for each music file
  Future <List> fetchData()async{
      musicFiles.addAll(args.list);
      for(String item in musicFiles){
        await metaDataWork.fetchMetaData(item);
        metaFiles.add(metaDataWork.metaData);
      }
      return metaFiles;
  }
}


