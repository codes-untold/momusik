import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:provider/provider.dart';
import 'package:move_to_background/move_to_background.dart';


import '../Services/Arguments.dart';
import '../Services/Data.dart';
import '../Services/MetaData.dart';
import '../Widgets/MusicList.dart';
import '../constants/constants.dart';


class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List <Metadata> metaFiles = [];
  Metadata metaData;
  static List <String> musicFiles = [];
  var retriever = new MetadataRetriever();
  AudioPlayer audioPlayer = AudioPlayer();
  MetaDataWork metaDataWork = MetaDataWork();
  int count =0;


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        if(Provider.of<Data>(context).playing){
          MoveToBackground.moveTaskToBack();
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
                  flex: 9,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0,top: 50.0),
                        alignment: Alignment.topLeft,
                        child: Text('Mo-Music🎵',
                          style:TextStyle(fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Italianno',
                              color: Colors.white),),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('images/photo1.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                        ),
                      ),

                      FutureBuilder(
                        future: chee() ,
                        initialData: [],
                        builder: (context,snapshot){
                          if(snapshot.connectionState == ConnectionState.done){


                            return musicFiles.isNotEmpty? MusicList(metaFiles: metaFiles,
                              musicFiles: musicFiles,
                              audioPlayer: audioPlayer,

                            ):  Container(
                              height: MediaQuery.of(context).size.height* 0.5,
                              width: MediaQuery.of(context).size.width *0.8,
                              child: Center(
                                  child: Text(""
                                      "Couldn't fetch music files (Android version < 11)"
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

  Future <List> chee()async{

    if(count == 0){
      String tin;
      final ScreenArguments args = ModalRoute.of(context).settings.arguments;
      musicFiles.addAll(args.list);
      print(ModalRoute.of(context).settings.name);
      for(tin in musicFiles){
        await metaDataWork.fetchMetaData(tin);
        metaFiles.add(metaDataWork.metaData);
        count++;

      }
      return metaFiles;
    }


    else{

    }

  }
}

