import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
String img='';
Widget ww=placeholder();
String tex="Click your meal";
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
  double height = 10;
  double width = 10;

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
      final snackBar = SnackBar(content: Text('Yay! Success'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Error from image repo ${snapshot.state.toString()}');
      throw ('This file is not an image');
    }
  }


  void filee()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['jpg','png','jpeg'],);
print(result?.files.single.path);

if(result != null){
  File file = File(result.files.single.path.toString());
    print("asad"+file.toString());
    setState(() {
      ww=imgggg();
      img=result.files.single.path.toString();
    });
  upload(result.files.single.path.toString(), result.files.first.name);
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
                                      firebaseinstance()));
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
                            'images/Vector.png',
                          )),
                          ww,
                          Image(
                            image: AssetImage(
                              'images/Vector (1).png',
                            ),
                          ),
                        ],
                      ),
                      Text(tex,style: TextStyle(fontSize: 20),),
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
                            filee();
                            setState(() {
                              tex="Will you eat this?";
                              icon_w=icon_c;
                              height = height + 20.0;
                              width = width + 20.0;
                            });
                          },
                        ),
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
          'images/Vector (2).png',
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

