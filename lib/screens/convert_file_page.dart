import 'dart:convert';
import 'dart:io';

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
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  String fileDirectory;
  bool _multiPick = false;
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
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
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
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  Future<void> excelToJson() async {
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

    File file = await File('${directory.path}/bbbb.json').create();
    await file.writeAsString(fullJson);
    print(file.exists().toString());


  }

 


  Future<void> jsonToExcel() async{
    String jsonString = await rootBundle.loadString("assets/subway_stations_name.json");

    List<dynamic> jsonResult = jsonDecode(jsonString)["DATA"];


    var excel = Excel.createExcel();
    Sheet sheetObject = excel['SheetName'];

    Map<String,dynamic> result = jsonResult[0];
    sheetObject.appendRow(result.keys.toList());

    for(int i =0;i<jsonResult.length;i++){
      Map<String,dynamic> result = jsonResult[i];
      sheetObject.appendRow(result.values.toList());
    }
    final directory = await getExternalStorageDirectory();

    excel.encode().then((onValue) {
      File(("${directory.path}/excel.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });


    print(sheetObject);
//    print(result.keys.toList());
//    print(result.values.toList());
    //    List<dynamic> aaa = jsonResult[0];
//    print("aaa : ${aaa[0]}");
    }
//  void _clearCachedFiles() {
//    FilePicker.platform.clearTemporaryFiles().then((result) {
//      _scaffoldKey.currentState.showSnackBar(
//        SnackBar(
//          backgroundColor: result ? Colors.green : Colors.red,
//          content: Text((result
//              ? 'Temporary files removed with success.'
//              : 'Failed to clean temporary files')),
//        ),
//      );
//    });
//  }

//  void _selectFolder() {
//    FilePicker.platform.getDirectoryPath().then((value) {
//      setState(() => _directoryPath = value);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('File Picker example app'),
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                    Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: Text("Open file picker"),
                      ),
                    ),
                    RaisedButton(
                      onPressed: ()=> jsonToExcel(),
                    ),
                    Builder(
                      builder: (BuildContext context) => _loadingPath
                          ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator(),
                      )
                          : _directoryPath != null
                          ? ListTile(
                        title: Text('Directory path'),
                        subtitle: Text(_directoryPath),
                      )
                          : _paths != null
                          ? Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        height:
                        MediaQuery.of(context).size.height * 0.50,
                        child: Scrollbar(
                            child: ListView.separated(
                              itemCount:
                              _paths != null && _paths.isNotEmpty
                                  ? _paths.length
                                  : 1,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final bool isMultiPath =
                                    _paths != null && _paths.isNotEmpty;
                                final String name = 'File $index: ' +
                                    (isMultiPath
                                        ? _paths
                                        .map((e) => e.name)
                                        .toList()[index]
                                        : _fileName ?? '...');
                                final path = _paths
                                    .map((e) => e.path)
                                    .toList()[index]
                                    .toString();
                                fileDirectory = path;
                                return ListTile(
                                  title: Text(
                                    name,
                                  ),
                                  subtitle: Text(path),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                              const Divider(),
                            )),
                      )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}