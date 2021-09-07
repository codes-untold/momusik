
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:momusik/Services/Arguments.dart';
import 'package:momusik/Services/Data.dart';
import 'package:momusik/Services/HelperFunctions.dart';
import 'package:momusik/Widgets/MusicTile.dart';
import 'package:momusik/constants/constants.dart';
import 'package:provider/provider.dart';

import 'BottomBarText.dart';

class MusicList extends StatefulWidget  {
  MusicList({
    @required this.metaFiles,
    @required this.musicFiles,
    this.audioPlayer,

  }) ;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  final audioPlayer;

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  int value = 0;
  bool isTrackLoaded = false;
  Data provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<Data>(context,listen: false);

  }

  @override
  Widget build(BuildContext context) {
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
                      onClickEvent(i);
                      Navigator.pushNamed(context, "/second",arguments:
                      SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,currentFile: i,audioPlayer: widget.audioPlayer));
                    },

                    child: MusicTile(trackName: widget.metaFiles[i].trackName,
                      trackDuration: widget.metaFiles[i].trackDuration,
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
                onTap: (){
                  Navigator.pushNamed(context, "/second",arguments:
                  SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,
                      currentFile: provider.selected ,audioPlayer: widget.audioPlayer));

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
                                BottomBarText(
                                  metaFiles: widget.metaFiles,
                                  rawFileString: HelperFunction().getRawFilename(widget.musicFiles[provider.selected]),
                                  currentNo: provider.selected,
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(widget.metaFiles[provider.selected].trackArtistNames != null?
                                widget.metaFiles[provider.selected].trackArtistNames[0]:"Unknown",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70
                                  ),),
                              ],
                            ),
                          ],
                        ),),


                      Expanded(flex: 2,
                        child: Consumer<Data>(
                          builder: (__,providerData,_){
                            return IconButton(
                              icon: Icon(providerData.playing?Icons.pause:Icons.play_arrow,
                                color: Colors.blue[200],
                              ),
                              onPressed: (){
                               handleBottomIconState(providerData);
                              },
                              iconSize: 30.0,

                            );
                          },

                        ),)],
                  ),
                ),
              ),
            )  ],
        ),
      ),
    );
  }

  //handles operation when an item from list of music
  //tracks is clicked
  void onClickEvent(int i){
    isTrackLoaded = true;

    widget.audioPlayer.pause();  //pauses audio if a music track was playing previously
    widget.audioPlayer.play(widget.musicFiles[i], isLocal: true);
    provider.selected = i;      //updates selected music index

    if(!provider.playing){     //changes playing state if music track wasn't playing previously
      setState(() {
        provider.changeState();
      });
    }
  }


  //updates icon according to the playing state
  void handleBottomIconState(providerData){
    setState(() {
      if(isTrackLoaded == false){
        if(providerData.playing== false){
          widget.audioPlayer.play(widget.musicFiles[value], isLocal: true);
          provider.changeState();
        }
        else{
          widget.audioPlayer.pause();
          provider.changeState();
        }

      }
      else{
        if(provider.playing == true){
          provider.changeState();
          widget.audioPlayer.pause();
        }
        else{
          provider.changeState();
          widget.audioPlayer.play(widget.musicFiles[provider.selected], isLocal: true);
        }
      }
    });
  }
}
