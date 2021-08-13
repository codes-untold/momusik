
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../Services/Data.dart';
import '../Services/TrackDuration.dart';

class MusicTile extends StatefulWidget {

  final String rawFileName;
  final String trackName;
  List <dynamic> ArtistName;
  final int trackDuration;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  final int currentFile;


  MusicTile({
    this.trackName,
    this.trackDuration,
    this.ArtistName,
    this.rawFileName,
    this.metaFiles,
    this.musicFiles,
    this.currentFile,

  });

  @override
  _MusicTileState createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {

  @override
  Widget build(BuildContext context) {
    TrackDuration trackcount = TrackDuration();
    trackcount.changeDuration(widget.trackDuration);

    int index1 = widget.rawFileName.lastIndexOf("/");
    int index2 = widget.rawFileName.indexOf(".mp3");
    String rawRaw = widget.rawFileName.substring(index1+1,index2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: Row(
            children: [
              Icon(
                Icons.sort,
                color: Colors.white54,
              ),

              SizedBox(
                width: 30.0,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.metaFiles[widget.currentFile].trackName == null? rawRaw: widget.metaFiles[widget.currentFile].trackName.length >25
                      ?"${widget.metaFiles[widget.currentFile].trackName.substring(0,23)}... ": widget.metaFiles[widget.currentFile].trackName ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,


                    ),),
                  Text( widget.metaFiles[widget.currentFile].trackArtistNames == null? "Unknown  .${trackcount.minute}"
                      ": ${trackcount.second}": "${widget.metaFiles[widget.currentFile].trackArtistNames[0]} .${trackcount.minute} : ${trackcount.second}",
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.0
                    ),)
                ],
              ),
              SizedBox(
                height: 55.0,
              ),


            ],
          ),
        ),
        Expanded(
          flex: 2,
          child:  Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Visibility(
              visible:Provider.of<Data>(context).playing == true? Provider.of<Data>(context).selected==widget.currentFile?true:false:false,
              child: SpinKitWave(
                color: Colors.blue[100],
                size: 15.0,
              ),
            ),
          ),
        )],
    );
  }
}