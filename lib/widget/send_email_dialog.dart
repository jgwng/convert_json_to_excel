import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class SendEmailDialog extends StatelessWidget{
  final String fileDirectory;
  SendEmailDialog({Key key, this.fileDirectory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("이메일로 파일 전송하시겠습니까?",style: TextStyle(fontWeight: FontWeight.w500,fontFamily:"DoHyeon",fontSize: 15),),
        actions: [
          new FlatButton(
            onPressed: () => send(fileDirectory),
            child: new Text("예"),
          ),
          new FlatButton(
            onPressed: () =>  Navigator.pop(context),
            child: new Text("아니오"),
          )]
    );
  }

  Future<void> send(String fileDirectory) async {
//    final dirPath = '${directory.path}/aaaa' ;
//    await new Directory(dirPath).create();

    final Email email = Email(
      body: "변환한 파일 첨부합니다",
      subject: "[파일 변환]",
      recipients: [""],
      attachmentPaths: [fileDirectory],

    );


    try {
      await FlutterEmailSender.send(email);

    } catch (error) {
    }


  }
}