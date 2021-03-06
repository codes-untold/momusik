
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:momusik/Services/DirectoryLogic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Services/Arguments.dart';


class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

DirectoryLogic directoryLogic = DirectoryLogic();

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool isVisible = false;
  BuildContext context;

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                child: welcomeLogo((){
                  setState(() {
                    isVisible = true;
                    moveToNextScreen(context);
                  });

                }),

              ),
              Positioned(
                bottom: 20,
                left: 5.0,
                right: 5.0,

                child: Visibility(
                  visible: isVisible,
                  child: Container(
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),

                ),
              )
            ],

          ),
        ),
        decoration:  BoxDecoration(
          color: Color(0xff060518),
          image: DecorationImage(image: AssetImage('images/photo1.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop)),
        ),
      ),
    );
  }


//fetch music files and move to home screen
  void moveToNextScreen(BuildContext context)async{
    await directoryLogic.fetchData((){
      print(directoryLogic.musicFiles,);
      Navigator.pushReplacementNamed(context, "/first",arguments:
      ScreenArguments(list: directoryLogic.musicFiles));
    },context);

  }




Widget welcomeLogo(Function function) {
    return TypewriterAnimatedTextKit(
      textAlign: TextAlign.center,
      alignment: Alignment.center,
      onFinished:function,
      totalRepeatCount: 1,
      speed: Duration(milliseconds: 200),
      text: ['Mo-Music????'],
      textStyle: TextStyle(fontSize: 30.0,
          fontWeight: FontWeight.w700,
          textBaseline: TextBaseline.alphabetic,
          fontFamily: 'IndieFlower',),

    );
  }

}


