import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FileNameDialog extends StatelessWidget{
  final BuildContext context;
  FileNameDialog({Key key, this.context}) : super(key: key);



  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text("파일 이름을 입력하세요"),
      content: TextField(
        controller: textEditingController,
        style: TextStyle(
            fontWeight: FontWeight.w500,fontFamily:"DoHyeon",fontSize: 15
        ),
        decoration: InputDecoration(
          hintText: "확장자명 제외하고 입력해 주세요.",
          hintStyle: TextStyle(fontWeight: FontWeight.w500,fontFamily:"DoHyeon",fontSize: 15),

        ),
      ),
      actions: [
        new FlatButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(textEditingController.text),
          child: new Text("예"),
      ),
        new FlatButton(
          onPressed: () =>  Navigator.of(context, rootNavigator: true).pop(null),
          child: new Text("아니오"),
        )],
    );
  }

}