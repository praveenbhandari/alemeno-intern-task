import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Future<void> upload() async {
    final Directory systemTempDir = Directory.systemTemp;
    final byteData = await rootBundle.load("images/1.png");
    // final byteDat = await rootBundle.load("/images/1.png");

    final file = File('${systemTempDir.path}/1.png');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    TaskSnapshot snapshot = await storage.ref().child("1.png").putFile(file);
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
                          Image(
                            image: AssetImage(
                              'images/Vector (2).png',
                            ),
                          ),
                          Image(
                            image: AssetImage(
                              'images/Vector (1).png',
                            ),
                          ),
                        ],
                      ),
                      Text("Click to add your meal",style: TextStyle(fontSize: 20),),
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
                          child: Icon(Icons.camera_alt,color: Colors.white,),
                          onPressed: () {
                            // upload();
                            setState(() {
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
