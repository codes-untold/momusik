import 'dart:async';
import 'dart:io';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class MetaDataWork{

  Metadata metaData;
  var retriever = new MetadataRetriever();

  void fetchMetaData(String path)async{
    await retriever.setFile(new File(path));
    metaData = await retriever.metadata;

  }

}