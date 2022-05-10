import 'dart:io';
import 'dart:ui';

import 'package:almeno/exit.dart';
import 'package:almeno/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
String img='';
Widget ww=placeholder();
String tex="Click your meal";
int cc=0;
Widget icon_w=Icon(Icons.camera_alt,color: Colors.white,);
Widget icon_c=Icon(Icons.check,color: Colors.white,);

class firebaseinstance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return MaterialApp(
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              // resizeToAvoidBottomPadding: false,
              body: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(home: Scaffold(body: home_page()));
        }

        return MaterialApp(
          home: Scaffold(

            body: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  var storage = FirebaseStorage.instance;
  double height = 50;
  double width = 50;

  Future<void> upload(String pathh,String name) async {
    // final Directory systemTempDir = Directory.systemTemp;
    // final byteData = await rootBundle.load(pathh);
    // final byteDat = await rootBundle.load("/images/1.png");
print("byte");
    final file = File(pathh);
print("ff"+file.toString());
    // await file.writeAsBytes(byteData.buffer
    //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    TaskSnapshot snapshot = await storage.ref().child(name).putFile(file);
    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print(downloadUrl);
      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .add({"url": downloadUrl, "name": imageName});
      // setState(() {
      //   isLoading = false;
      // });

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                  exittt()));
    } else {
      print('Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }
  }


  String pathh="",nameee="";
  void filee()async{
if(cc<2){
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
    allowedExtensions: ['jpg','png','jpeg'],);
  print(result?.files.single.path);

  if(result != null){
    File file = File(result.files.single.path.toString());
    print("asad"+file.toString());
    setState(() {
      ww=imgggg();
      img=result.files.single.path.toString();
      height = height + 20.0;
      width = width + 20.0;
      pathh=result.files.single.path.toString();
      nameee=result.files.first.name;
    });
  }}
print(cc);
    if(cc == 2) {
      print("uploading................");
      print(pathh);
      print(nameee);
      upload(pathh,nameee );
    }
    // File file = await FilePicker.getFile
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf','docx'], //here you can add any of extention what you need to pick
    // );
    // if (result != null) {
    //   File file = File(result.files.single.path);
    //   print(file);
    // } else {
    //   // User canceled the picker
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(

        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Container(
                      decoration:  BoxDecoration(
            color: Colors.green,
              border: Border.all(
                    color: Colors.green,
              ),
              shape: BoxShape.circle,
            ),
                      child: FlatButton(
                        child: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      main_page()));
                        },
                      ),
                    ),
                    SizedBox(width: 40,)
                  ],
                ),
                Image(
                  image: AssetImage(
                    'images/baby S.png',
                  ),
                  height: height,
                  width: width,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),),
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                              image: AssetImage(
                            'images/fork.png',
                          )),
                          ww,
                          Image(
                            image: AssetImage(
                              'images/spoon.png',
                            ),
                          ),
                        ],
                      ),
                      Text(tex,style: TextStyle(fontSize: 20),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: FlatButton(
                              // color: Colors.green,
                              child: icon_w,
                              onPressed: () {
                                // upload();
                                cc += 1;
                                filee();

                                setState(() {

                                  print("cc : "+cc.toString());
                                  tex="Will you eat this?";
                                  icon_w=icon_c;
                                  filee();

                                  // height = height + 20.0;
                                  // width = width + 20.0;
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.green,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: FlatButton(
                              // color: Colors.green,
                              child: Icon(Icons.refresh_sharp,color: Colors.white,),
                              onPressed: () {
                                // upload();
                                // filee();
                                setState(() {
                                  cc = 0;

                                  ww=placeholder();
                                  print("cc : "+cc.toString());
                                  tex="Click your meal";
                                  icon_w=Icon(Icons.camera_alt,color: Colors.white,);
                                  height = 20;
                                  width =  20;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class placeholder extends StatelessWidget {
  const placeholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
        image: AssetImage(
          'images/circle.png',
        ));
  }
}

class imgggg extends StatelessWidget {
  const imgggg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: CircleAvatar(
// backgroundImage: ,
        // radius: 20,
        backgroundColor: Colors.grey[700],
        child: ClipOval(
          child: Image.file(File(img),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

