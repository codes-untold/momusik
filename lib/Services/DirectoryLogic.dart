import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class DirectoryLogic{

  List <String> musicFiles = [];

  fetchData(Function function,BuildContext context)async{


    await Permission.storage.request();

    if(await Permission.storage.isGranted){
      print('granted');

      final Directory dir =  Directory((await getExternalStorageDirectory()).path.toString().substring(0,20));

      dir.list(recursive: true).listen((FileSystemEntity entity) {
        if(entity.path.contains('mp3') ){
          musicFiles.add(entity.path);
        }
      },onDone: function,);
    }

    else{
      await AppSettings.openAppSettings();
    }
  }




}