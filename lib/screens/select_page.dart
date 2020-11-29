import 'dart:async';

import 'package:convertjsontoexcel/screens/convert_file_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text("Convert Files To What...",style: TextStyle(
              color: Colors.black,fontSize: 26,fontFamily:"DoHyeon",fontWeight: FontWeight.w500
            ),),
            SizedBox(height : 100),
            Container(
              width: 250,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilePickerDemo()));
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Convert Json to Excel File".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(height : 100),
            Container(
              width: 250,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () {},
                color: Colors.black,
                textColor: Colors.white,
                child: Text("Convert Excel to Json File".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
