import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class DevicePage extends StatefulWidget{
  DevicePage({Key key}) : super(key : key);

  @override
  _DevicePageState createState() => new _DevicePageState();
}

class _DevicePageState extends State<DevicePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("设备管理", style: TextStyle(color: GTheme.Colors.textColorB),),
        backgroundColor: GTheme.Colors.mainBackColor,
        iconTheme: IconThemeData(color: GTheme.Colors.textColorB),
        elevation: 1,
      ),
      bottomSheet: Text("sd"),
    );
  }
}