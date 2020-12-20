import 'package:convertjsontoexcel/constants/app_theme.dart';
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
        style: AppThemes.textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: "확장자명 제외하고 입력해 주세요.",
          hintStyle: AppThemes.textTheme.bodyText1,

        ),
      ),
      actions: [
        new FlatButton(
        onPressed: () => Navigator.pop(context,textEditingController.text),
          child: new Text("예"),
      ),
        new FlatButton(
          onPressed: () =>  Navigator.pop(context),
          child: new Text("아니오"),
        )],
    );
  }

}