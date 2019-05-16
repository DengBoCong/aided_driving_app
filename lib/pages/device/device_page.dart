import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/widgets/dialog/tip_dialog.dart';

class DevicePage extends StatefulWidget{
  DevicePage({Key key}) : super(key : key);

  @override
  _DevicePageState createState() => new _DevicePageState();
}

class _DevicePageState extends State<DevicePage>{
  Widget _buildItem(VoidCallback callback){
    return new GestureDetector(
      onTap: callback,
      child: Icon(Icons.autorenew),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TipDialogContainer(
      duration: const Duration(seconds: 2),
      child: Scaffold(
        appBar: AppBar(
          title: Text("设备管理", style: TextStyle(color: GTheme.Colors.textColorB),),
          backgroundColor: GTheme.Colors.mainBackColor,
          iconTheme: IconThemeData(color: GTheme.Colors.textColorB),
          elevation: 1,
        ),
        bottomNavigationBar: new TipDialogConnector(
            builder: (context, tipController){
              return BottomAppBar(
                child: Container(
                  height: 50.0,
                  child: Center(
                    child: _buildItem(() async{
                      tipController.show(
                        tipDialog: new TipDialog(
                          tip: "正在搜索设备",
                          type: TipDialogType.LOADING,
                        ),
                      );
                      await new Future.delayed(new Duration(seconds: 4));
                    }),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}