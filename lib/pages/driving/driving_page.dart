import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/widgets/chart/circularprogress/gradient_circular_progress_indicator.dart';

class DrivingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SleepPage(),
        ),
      ),
    );
  }
}

class SleepPage extends StatefulWidget{
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage>
  with TickerProviderStateMixin{
  final baseColor = Color.fromRGBO(119, 180, 245, 0.3);
  AnimationController _animationController;

  int initTime;
  int endTime;

  int inBedTime;
  int outBedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shuffle();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          /*_animationController.reverse();*/
          _animationController.reset();
          _animationController.forward();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void _shuffle(){
    setState((){
      initTime = _generateRandomTime();
      endTime = _generateRandomTime();
      inBedTime = initTime;
      outBedTime = endTime;
    });
  }

  void _updateLabels(int init, int end){
    setState((){
      inBedTime = init;
      outBedTime = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          '实时驾驶数据图表显示',
          style: TextStyle(color: GTheme.Colors.textColorB),
        ),
        Padding(
          padding: EdgeInsets.only(right: 35),
          child: Divider(
            indent: 35.0,
          ),
        ),
        Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child){
                return Padding(
                  padding: const EdgeInsets.only(top: 17.0,left: 17),
                  child: GradientCircularProgressIndicator(
                    colors: [Color.fromRGBO(119, 180, 245, 0.2), Color.fromRGBO(119, 180, 245, 0.8)],
                    radius: 93.0,
                    stokeWidth: 5.0,
                    value: _animationController.value,
                    strokeCapRound: true,
                  ),
                );
              },
            ),
            CircularSlider(
              288,
              initTime,
              endTime,
              height: 220.0,
              width: 220.0,
              baseColor: Color.fromRGBO(119, 180, 245, 0.1),
              selectionColor: baseColor,
              handlerColor: GTheme.Colors.mainColor,
              handlerOutterRadius: 12.0,
              onSelectionChange: _updateLabels,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    '${_formatIntervalTime(inBedTime, outBedTime)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: GTheme.Colors.mainColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 35),
          child: Divider(
            indent: 35.0,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatBedTime('交通信号灯(红/黄/绿)', inBedTime),
          _formatBedTime('车前行人(车速比率)', inBedTime),
        ]),
        Padding(
          padding: EdgeInsets.only(right: 35),
          child: Divider(
            indent: 35.0,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatBedTime('车道线虚线距离(左/右)', inBedTime),
          _formatBedTime('车道线实线距离(左/右)', inBedTime),
        ]),
        Padding(
          padding: EdgeInsets.only(right: 35),
          child: Divider(
            indent: 35.0,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatBedTime('行驶侧车辆距离(前/后)', inBedTime),
          _formatBedTime('车辆行驶速度(当前/限速)', inBedTime),
        ]),
        Padding(
          padding: EdgeInsets.only(right: 35),
          child: Divider(
            indent: 35.0,
          ),
        ),
        FlatButton(
          child: Text('检测设备运行正常'),
          color: baseColor,
          textColor: GTheme.Colors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: _shuffle,
        ),
      ],
    );
  }

  Widget _formatBedTime(String pre, int time) {
    return Column(
      children: [
        Text(pre, style: TextStyle(color: GTheme.Colors.textColorB)),
        Text(
          '查看详参',
          style: TextStyle(
            color: Color.fromRGBO(49, 51, 53, 0.5),
            fontSize: 13,
          ),
        ),
        Text(
          '${_formatTime(time)}',
          style: TextStyle(color: GTheme.Colors.mainColor),
        )
      ],
    );
  }

  String _formatTime(int time) {
    if (time == 0 || time == null) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    return '$hours:$minutes';
  }

  String _formatIntervalTime(int init, int end) {
    var sleepTime = end > init ? end - init : 288 - init + end;
    var hours = sleepTime ~/ 12;
    var minutes = (sleepTime % 12) * 5;
    /*return '${hours}h${minutes}m';*/
    return '${sleepTime}\n驾驶评级\nA';
  }

  int _generateRandomTime() => Random().nextInt(288);
}