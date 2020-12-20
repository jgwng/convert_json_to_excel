import 'dart:async';

import 'package:convertjsontoexcel/screens/convert_file_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget{
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>  with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  startTimer(){
    var duration = new Duration(seconds: 3);
    return new Timer(duration,navigatorPage);
  }
  navigatorPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ConvertFile()));
  }


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, duration: Duration(seconds: 3,),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );

    startTimer();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child:
          SizedBox(
            height: 250,
            width: 250,

            child: Image.asset("assets/images/documents.png",fit: BoxFit.fill,),
          ),
        ),
      ),
    );
  }
}

