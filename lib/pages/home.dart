import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '主页',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text("哈哈哈"),
        ),
      ),
    );
  }
}