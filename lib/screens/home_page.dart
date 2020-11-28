import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    print("AAAA");
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
