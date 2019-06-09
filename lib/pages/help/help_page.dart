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
  List<String> _list = [
    "我的年度健康汇总报告在哪里看?",
    "没有TTS健康状态播报，哪里可以打开?",
    "我的辅助驾驶检测设备损坏，如何解决?",
    "去哪里设计健康检测的时间间隔?",
    "检测闪退、自动暂停检测问题如何解决?",
    "哪些机型能够完美适配系统?",
    "检测数据评价结论与实际情况不符，如何上报?",
    "如何同步数据?",
    "私人医生能否设置多个?",
    "换了手机号，如何一键同步云端历史数据?",
    "如何防止我们升级我的账户?"
  ];

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
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(_list[index]),
            trailing: Icon(Icons.chevron_right),
          );
        },
        leading: CircleAvatar(
          child: Icon(Icons.search, color: GTheme.Colors.textColorB,),
          backgroundColor: Colors.transparent,
        ),
        /*endDrawer: Drawer(
          child: Container(),
        ),*/
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