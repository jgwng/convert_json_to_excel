import 'dart:convert';
import 'dart:io';

import 'package:convertjsontoexcel/utils/convert_file.dart';
import 'package:convertjsontoexcel/utils/dialog.dart';
import 'package:convertjsontoexcel/widget/alert_dialog.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile> _paths;
  String _extension;
  bool _loadingPath = false;
  String newFileName= "";
  String fileDirectory;
  bool selectedFile = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      fileDirectory = _paths[0].path;
      selectedFile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Covert file to What you want'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3
                        )
                      ),
                      child: selectedFile ? Image.asset('assets/images/documents.png') : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: Text("Open file picker"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () async {
                          print(fileDirectory);
//                        print(_directoryPath);
////                        print(_paths[0].path);
                          newFileName = await fileNameDialog(context);
                          if(newFileName != null){
                            await excelToJson(newFileName,fileDirectory,_scaffoldKey);
//                            await jsonToExcel(newFileName,fileDirectory,_scaffoldKey);
                          }
                        },
                        child: Text("Convert"),
                      ),
                      SizedBox(width: 30,),
                      RaisedButton(
                        onPressed: (){
                          
                        },
                        child: Text("Send Email"),
                      )
                    ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}