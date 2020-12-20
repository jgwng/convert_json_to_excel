import 'package:convertjsontoexcel/widget/error_dialog.dart';
import 'package:convertjsontoexcel/widget/file_name_dialog.dart';
import 'package:convertjsontoexcel/widget/no_file_dialog.dart';
import 'package:convertjsontoexcel/widget/send_email_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String> fileNameDialog(BuildContext context) async{
  String result = await showDialog(
    context: context,
    builder: (context){
      return FileNameDialog();
    }
  );
  return result;
}

void sendEmailDialog(BuildContext context,String directory) async{
   showDialog(
      context: context,
      builder: (context){
        return SendEmailDialog(fileDirectory: directory,);
      }
  );
}

void errorDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context){
        return ErrorDialog();
      }
  );
}

void noFileDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context){
        return NoFileDialog();
      }
  );
}
