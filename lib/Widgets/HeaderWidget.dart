import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0,top: 50.0),
      alignment: Alignment.topLeft,
      child: Text('Mo-Music🎵',
        style:TextStyle(fontSize: 30.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'IndieFlower',
            color: Colors.white),),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/photo1.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)),
      ),
    );
  }
}
