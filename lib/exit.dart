import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exit extends StatelessWidget {
  const exit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FlatButton(
            onPressed: () {},
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "GOOD JOB",
                style: TextStyle(fontSize: 50,color: Colors.green,fontWeight: FontWeight.bold ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class exittt extends StatefulWidget {
  const exittt({Key? key}) : super(key: key);

  @override
  State<exittt> createState() => _exitttState();
}

class _exitttState extends State<exittt> {
  void initState(){

    super.initState();
    Future.delayed(Duration.zero, () {
      this.snak();
    });
  }

  void snak(){
    final snackBar = SnackBar(content: Text('Successfully Uploaded',style: TextStyle(color: Colors.black),),backgroundColor: Colors.yellow,duration: Duration(seconds: 10),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "GOOD JOB",
            style: TextStyle(fontSize: 50,color: Colors.green,fontWeight: FontWeight.bold ),
          ),
        ),
      ),
    ),
  );

  }
}
