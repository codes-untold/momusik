
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:momusik/Services/HelperFunctions.dart';
import 'package:momusik/Widgets/TrackText.dart';
import 'package:provider/provider.dart';

import '../Services/Data.dart';
import '../Services/TrackDuration.dart';
import 'TrackText2.dart';

class MusicTile extends StatefulWidget {

  final String rawFileName;
  final String trackName;
  final int trackDuration;
  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  final int currentFile;


  MusicTile({
    this.trackName,
    this.trackDuration,
    this.rawFileName,
    this.metaFiles,
    this.musicFiles,
    this.currentFile,
  });

  @override
  _MusicTileState createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {

  int index1;
  int index2;
  String rawFileString;
  TrackDuration trackCount = TrackDuration();
  Data provider;

  @override
  void initState() {
    super.initState();
    trackCount.changeDuration(widget.trackDuration);
    provider = Provider.of<Data>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
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

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                TrackText(metafiles: widget.metaFiles,currentNo: widget.currentFile,
                  rawFileString: HelperFunction().getRawFilename(widget.rawFileName),),

                 TrackText2(metaFiles: widget.metaFiles,currentNo: widget.currentFile,
                   trackCount: trackCount,rawFileString: HelperFunction().getRawFilename(widget.rawFileName),)
                  ],
                ),
              ),
              SizedBox(
                height: 55.0,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child:  Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Consumer<Data>(
              builder: (__,providerData,_){
                return Visibility(
                  visible: provider.playing? providerData.selected == widget.currentFile? true: false: false,
                  child: SpinKitWave(
                    color: Colors.blue[100],
                    size: 15.0,
                  ),
                );
              },
            ),
          ),
        )],
    );
  }

}