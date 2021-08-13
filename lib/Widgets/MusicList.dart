import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'file:///C:/Users/xeroes/AndroidStudioProjects/momusik/lib/Services/Data.dart';
import 'file:///C:/Users/xeroes/AndroidStudioProjects/momusik/lib/Services/Methods.dart';
import 'package:momusik/constants/constants.dart';
import 'package:provider/provider.dart';

import '../Services/Arguments.dart';
import 'MusicTile.dart';


class MusicList extends StatefulWidget  {
  MusicList({
    @required this.metaFiles,
    @required this.musicFiles,
    this.audioPlayer
  }) ;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  static final Method method = Method();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  //AudioPlayer audioPlayer = AudioPlayer();
  IconData icon;
  int value;
  bool loaded = false;
  bool loadedstate = false;

  @override
  void initState() {
    super.initState();

    value = Method().dowork(widget.musicFiles);
  }

  @override
  Widget build(BuildContext context) {

    icon = Provider.of<Data>(context).playing? Icons.pause:Icons.play_arrow;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: ListView.builder(itemBuilder: (BuildContext context,int i){
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: GestureDetector(
                    onTap: ()async{
                      loaded = true;

                      widget.audioPlayer.pause();
                      widget.audioPlayer.play(widget.musicFiles[i], isLocal: true);


                      Provider.of<Data>(context).selected = i;

                      if(!Provider.of<Data>(context).playing){
                        setState(() {
                          Provider.of<Data>(context).changeState();
                          icon = Icons.pause;
                        });
                      }

                      final result =  await Navigator.pushNamed(context, "/second",arguments:
                      SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,currentFile: i,audioPlayer: widget.audioPlayer));


                      setState(() {
                        Provider.of<Data>(context).selected = result;
                        print("fgbxdfdfzxdf");

                      });


                    }
                    ,
                    child: MusicTile(trackName: widget.metaFiles[i].trackName,
                      trackDuration: widget.metaFiles[i].trackDuration,
                      ArtistName: widget.metaFiles[i].trackArtistNames,
                      rawFileName: widget.musicFiles[i],
                      currentFile: i,
                      musicFiles: widget.musicFiles,
                      metaFiles: widget.metaFiles,

                    ),
                  ),
                );
              },
                shrinkWrap: true,
                itemCount: widget.metaFiles.length,


              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: ()async{
                  final result =  await Navigator.pushNamed(context, "/second",arguments:
                  SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,currentFile:
                  Provider.of<Data>(context).selected  == null ? value:Provider.of<Data>(context).selected ,audioPlayer: widget.audioPlayer));
                  if(result == false){
                    setState(() {
                    });
                  }

                },
                child: Container(
                  decoration: gradient_color,
                  child: Row(

                    children: [
                      Expanded(flex: 8,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage('images/albumart.jpeg'),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<Data>(context).selected  == null ? widget.metaFiles[value].trackName == null? MusicList.method.work(widget.musicFiles[value]): widget.metaFiles[value].trackName.length>25
                                    ?"${widget.metaFiles[value].trackName.substring(0,15)}... ": widget.metaFiles[value].trackName:
                                widget.metaFiles[Provider.of<Data>(context).selected ].trackName == null? MusicList.method.work(widget.musicFiles[Provider.of<Data>(context).selected ]): widget.metaFiles[Provider.of<Data>(context).selected ].trackName.length>25
                                    ?"${widget.metaFiles[Provider.of<Data>(context).selected ].trackName.substring(0,15)}... ": widget.metaFiles[Provider.of<Data>(context).selected ].trackName,

                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.white70
                                  ),),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(Provider.of<Data>(context).selected  == null ? widget.metaFiles[value].trackArtistNames != null?
                                widget.metaFiles[value].trackArtistNames[0]:"Unknown": widget.metaFiles[Provider.of<Data>(context).selected].trackArtistNames != null?
                                widget.metaFiles[Provider.of<Data>(context).selected].trackArtistNames[0]:"Unknown",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70
                                  ),),
                              ],
                            ),
                          ],
                        ),),


                      Expanded(flex: 2,
                        child: IconButton(
                          icon: Icon(icon,
                            color: Colors.blue[200],
                          ),
                          onPressed: (){
                            setState(() {

                              if(loaded == false){
                                if( Provider.of<Data>(context).playing == false){
                                  widget.audioPlayer.play(widget.musicFiles[value], isLocal: true);
                                  loadedstate = true;
                                  print('1st');
                                  Provider.of<Data>(context).changeState();
                                }
                                else{
                                  widget.audioPlayer.pause();
                                  loadedstate = false;
                                  print('2nd');
                                  Provider.of<Data>(context).changeState();
                                }

                              }
                              else{
                                if( Provider.of<Data>(context).playing == true){

                                  Provider.of<Data>(context).changeState();
                                  icon = Icons.play_arrow;
                                  widget.audioPlayer.pause();
                                }
                                else{
                                  Provider.of<Data>(context).changeState();
                                  icon = Icons.pause;
                                  widget.audioPlayer.play(widget.musicFiles[ Provider.of<Data>(context).selected], isLocal: true);
                                }
                              }

                            });
                            print("e suppose stop");
                          },
                          iconSize: 30.0,

                        ),)],
                  ),
                ),
              ),
            )  ],
        ),
      ),
    );
  }
}

