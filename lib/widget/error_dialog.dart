import 'package:convertjsontoexcel/constants/app_theme.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget{
  final BuildContext context;
  ErrorDialog({Key key, this.context}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        title: Text("첨부파일을 다시 확인해 주십시오.",style: AppThemes.textTheme.bodyText1,),
        actions: [
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text("확인",style: AppThemes.textTheme.bodyText1,),
          ),]
    );
  }
}