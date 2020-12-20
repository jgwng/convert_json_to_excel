

import 'package:convertjsontoexcel/constants/app_theme.dart';
import 'package:convertjsontoexcel/utils/convert_file.dart';
import 'package:convertjsontoexcel/utils/dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';


class ConvertFile extends StatefulWidget {
  @override
  _ConvertFileState createState() => _ConvertFileState();
}

class _ConvertFileState extends State<ConvertFile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile> _paths;
  String _extension;
  bool _loadingPath = false;
  String newFileName= "";
  int dropdownValue = 0;
  String fileDirectory;
  bool selectedFile = false;
  FileType _pickingType = FileType.any;
  List<String> selectList = ['ExcelToJson',"JsonToExcel"];
  List<String> extensionList = ['xlsx','json'];


  @override
  void initState() {
    super.initState();

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
      _extension = _paths[0].extension;
      print(_extension);
      selectedFile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Convert File to What You Want',style: AppThemes.textTheme.bodyText1),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3
                        )
                      ),
                      child: selectedFile ? Image.asset('assets/images/documents.png') : null,
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: 150,
                      child: RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: Text("Open file Browser",style: AppThemes.textTheme.bodyText1,),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                        height: 50.0,
                        width: 150.0,
                        child: DropdownButton(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          underline: Container(
                            height: 1,
                            color: Colors.black,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              print(dropdownValue);
                            });
                          },
                          items: <int>[0, 1]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(selectList[value]),
                            );
                          }).toList(),
                        )
                    ),
                    SizedBox(height: 80,),
                  Container(
                    width: 150,
                    child:RaisedButton(
                        onPressed: () async {
                          if(fileDirectory == null){
                            noFileDialog(context);

                          }
                          else{
                            if(_extension != extensionList[dropdownValue])
                            {
                              errorDialog(context);
                            }
                            else{
                              newFileName = await fileNameDialog(context);
                              if(dropdownValue == 0){
                                excelToJson(newFileName,fileDirectory,_scaffoldKey,context);
                              }else{
                                jsonToExcel(newFileName,fileDirectory,_scaffoldKey,context);
                              }
                            }
                          }
                        },
                        child: Text("Convert",style: AppThemes.textTheme.bodyText1,)
                    ),
                  ),
                    SizedBox(height: 50,),


                  ],
                ),
              ),
            ));
  }
}