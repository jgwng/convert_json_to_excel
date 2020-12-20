import 'dart:convert';
import 'dart:io';

import 'package:convertjsontoexcel/utils/dialog.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void excelToJson(String fileName, String fileDirectory,GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
  ByteData data = await rootBundle.load(fileDirectory);
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  int i = 0;
  List<dynamic> keys = new List<dynamic>();
  List<Map<String, dynamic>> json = new List<Map<String, dynamic>>();
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table].rows) {
      if (i == 0) {
        keys = row;
        i++;
      } else {
        Map<String, dynamic> temp = Map<String, dynamic>();
        int j = 0;
        String tk = '';
        for (var key in keys) {
          tk = '"' + key + '"';
          temp[tk] = (row[j].runtimeType == String)
              ? '"' + row[j].toString() + '"'
              : row[j];
          j++;
        }
        json.add(temp);
      }
    }
  }
  print(json.length);
  String fullJson = json.toString().substring(1, json
      .toString()
      .length - 1);

  fullJson = '{ "DATA" : [$fullJson]}';
  final directory = await getExternalStorageDirectory();
//    final dirPath = '${directory.path}/aaaa' ;
//    await new Directory(dirPath).create();

  File file = await File('${directory.path}/$fileName.json').create();
  await file.writeAsString(fullJson).then((value) => sendEmailDialog(context,'${directory.path}/$fileName.json'));

}

void jsonToExcel(String fileName, String fileDirectory,GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async{
  String jsonString = await rootBundle.loadString(fileDirectory);

  List<dynamic> jsonResult = jsonDecode(jsonString)["DATA"];


  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];

  Map<String,dynamic> result = jsonResult[0];
  sheetObject.appendRow(result.keys.toList());

  for(int i =0;i<jsonResult.length;i++){
    Map<String,dynamic> result = jsonResult[i];
    sheetObject.appendRow(result.values.toList());
  }
  final directory = await getExternalStorageDirectory();

  excel.encode().then((onValue) {
    File(("${directory.path}/$fileName.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(onValue);
    sendEmailDialog(context,'${directory.path}/$fileName.json');
  });


  print(sheetObject);
//    print(result.keys.toList());
//    print(result.values.toList());
  //    List<dynamic> aaa = jsonResult[0];
//    print("aaa : ${aaa[0]}");
}