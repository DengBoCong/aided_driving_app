import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/floating_search_bar.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class HelpPage extends StatefulWidget{
  HelpPage({Key key}) : super(key : key);

  @override
  _HelpPageState createState() => new _HelpPageState();
}

class _HelpPageState extends State<HelpPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("帮助与反馈", style: TextStyle(color: GTheme.Colors.textColorB),),
        backgroundColor: GTheme.Colors.mainBackColor,
        iconTheme: IconThemeData(color: GTheme.Colors.textColorB),
        elevation: 0,
      ),
      body: FloatingSearchBar.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        leading: CircleAvatar(
          child: Icon(Icons.search, color: GTheme.Colors.textColorB,),
          backgroundColor: Colors.transparent,
        ),
        endDrawer: Drawer(
          child: Container(),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "你好，需要什么帮助",
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("我要反馈", style: TextStyle(color: GTheme.Colors.mainColor, fontSize: 15),),
                onPressed: (){},
              ),
              FlatButton(
                child: Text("反馈历史", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}