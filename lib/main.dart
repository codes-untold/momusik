
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/Data.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/MusicScreen.dart';
import 'Screens/WelcomeScreen.dart';



void main() {

  runApp(ChangeNotifierProvider<Data>(
    create: (_)=> Data(),
    builder: (context,child){

      return MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context) => WelcomeScreen(),
          '/first':(context) => HomeScreen(),
          '/second':(context) => MusicScreen(),
        },

        debugShowCheckedModeBanner: false,
      );
    },

  ));
}
