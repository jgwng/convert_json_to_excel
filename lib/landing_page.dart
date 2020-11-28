import 'package:convertjsontoexcel/constants/size.dart';
import 'package:convertjsontoexcel/screens/home_page.dart';
import 'package:convertjsontoexcel/screens/intro_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: sizeIsNotZero(Stream<double>.periodic(
            Duration(milliseconds: 100),
                (x) => MediaQuery.of(context).size.width)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            size = MediaQuery.of(context).size;
            return FutureBuilder(
                future: Future.delayed(Duration(seconds: 2),),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done)
                    return HomePage();

                  return HomePage();

                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
