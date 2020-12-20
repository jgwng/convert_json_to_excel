import 'package:convertjsontoexcel/constants/app_theme.dart';
import 'package:flutter/material.dart';

class NoFileDialog extends StatelessWidget{
  final BuildContext context;
  NoFileDialog({Key key, this.context}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
        title: Text("파일을 업로드하여 주세요.",style: AppThemes.textTheme.bodyText1,),
        actions: [
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text("확인",style: AppThemes.textTheme.bodyText1,),
          ),]
    );
  }
}