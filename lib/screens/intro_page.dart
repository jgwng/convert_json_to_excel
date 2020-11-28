import 'dart:async';

import 'package:convertjsontoexcel/screens/home_page.dart';
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
    var duration = new Duration(seconds: 5);
    return new Timer(duration,navigatorPage);
  }
  navigatorPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this, duration: Duration(seconds: 2,),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );
    animationController.forward();
    startTimer();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation,
          child: Container(
            height: 100,
            width: 100,
            child: Image.asset("assets/images/documents.png"),
          ),
        ),
      ),
    );
  }
}

