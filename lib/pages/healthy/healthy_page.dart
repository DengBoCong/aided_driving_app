import 'package:flutter/material.dart';
import 'dart:math';
import 'package:aided_driving_app/widgets/chart/circularprogress/flukit.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/widgets/chart/circularprogress/animated_rotation_box.dart';
import 'package:aided_driving_app/widgets/chart/spider_chart.dart';
import 'package:aided_driving_app/widgets/dialog/data_dialog.dart';
import 'package:aided_driving_app/widgets/chart/sparkline.dart';

class HealthyPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GradientCircularProgressRoute(),
    );
  }
}

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  GradientCircularProgressRouteState createState() {
    return new GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '实时健康数据图表显示',
                        style: TextStyle(color: GTheme.Colors.textColorB),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 35, top: 15),
                        child: Divider(
                          indent: 35.0,
                        ),
                      ),
                      //剪裁半圆
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: AnimatedRotationBox(
                              duration: Duration(milliseconds: 2000),
                              child: GradientCircularProgressIndicator(
                                radius: 120.0,
                                colors: [Colors.blue, Colors.blue],
                                value: 0.01,
                                strokeCapRound: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30, left: 20),
                            child: SizedBox(
                              height: 104.0,
                              width: 200.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Positioned(
                                    height: 200.0,
                                    top: .0,
                                    child: TurnBox(
                                      turns: .75,
                                      child: GradientCircularProgressIndicator(
                                        colors: [Color.fromRGBO(119, 180, 245, 0.4), Color.fromRGBO(119, 180, 245, 1)],
                                        radius: 100.0,
                                        stokeWidth: 8.0,
                                        value: _animationController.value,
                                        totalAngle: pi,
                                        strokeCapRound: true,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text("${(_animationController.value*100).toInt()}%",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 130, left: 60),
                            child: Text(
                              '健康评级\nA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                                color: GTheme.Colors.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 35, top: 15),
                        child: Divider(
                          indent: 35.0,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 50, left: 12),
                                child: FlatButton(
                                  child: Text('心率 73次/分'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => DataDialog(
                                        key: Key("Network"),
                                        widget: new Center(
                                          child: new Container(
                                            width: 270.0,
                                            height: 200.0,
                                            child: new Sparkline(
                                              data: <double>[3,5,1,8,3,9,10],
                                              lineColor: GTheme.Colors.mainColor,
                                              pointsMode: PointsMode.all,
                                              pointSize: 8.0,
                                              pointColor: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '近一周的心率均值情况',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22.0, fontWeight: FontWeight.w600),
                                        ),
                                        description: Text(
                                          '根据您近一周的心率均指变化情况，利用人工智能大数据处理，我们得出初步的结论报告，报告内容如下：您在开车过程中存在明显心率不齐情况，可能是因为疲劳驾驶等原因导致',
                                          textAlign: TextAlign.center,
                                        ),
                                        onOkButtonPressed: () {},
                                      ),
                                    );
                                  },
                                ),/*Text('心率 73次/分')*/
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 80, right: 280),
                                child: Divider(indent: 20,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 0, left: 128),
                                child: FlatButton(
                                  child: Text('血压 121/79 mmHg'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (_) => DataDialog(
                                        key: Key("Network"),
                                        widget: new Center(
                                          child: new Container(
                                            width: 270.0,
                                            height: 200.0,
                                            child: new Sparkline(
                                              data: <double>[3,5,1,8,3,9,10],
                                              lineColor: GTheme.Colors.mainColor,
                                              pointsMode: PointsMode.all,
                                              pointSize: 8.0,
                                              pointColor: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '近一周的血压均值情况',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22.0, fontWeight: FontWeight.w600),
                                        ),
                                        description: Text(
                                          '根据您近一周的血压均指变化情况，利用人工智能大数据处理，我们得出初步的结论报告，报告内容如下：您在开车过程中存在明显血压参差不齐情况，可能是因为疲劳驾驶等原因导致',
                                          textAlign: TextAlign.center,
                                        ),
                                        onOkButtonPressed: () {},
                                      ),
                                    );
                                  },
                                )/*Text('血压 121/79 mmHg')*/,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30, right: 120),
                                child: Divider(indent: 140,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 50, left: 272),
                                child: FlatButton(
                                  child: Text('体温 37.7℃'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: (){},
                                )/*Text('体温 37.7 ℃')*/,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 80, right: 25),
                                child: Divider(indent: 280,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 50, left: 120),
                            child: Container(
                              width: 160,
                              height: 160,
                              child: SpiderChart(
                                data: [
                                  7,
                                  5,
                                  10,
                                  7,
                                  4,
                                  6,
                                ],
                                maxValue: 15,
                                colors: <Color>[
                                  Colors.red,
                                  Colors.green,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.indigo,
                                  Colors.grey,
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 148, left: 10),
                                child: FlatButton(
                                  child: Text('血氧饱和度 90%'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: (){},
                                )/*Text('血氧饱和度 90%')*/,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 180, right: 265),
                                child: Divider(indent: 20,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 210, left: 130),
                                child: FlatButton(
                                  child: Text('血脂 4.9mmol/L'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: (){},
                                )/*Text('血脂 4.9 mmol/L')*/,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 240, right: 138),
                                child: Divider(indent: 140,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 150, left: 270),
                                child: FlatButton(
                                  child: Text('体重 58.7kg'),
                                  textColor: GTheme.Colors.textColorB,
                                  onPressed: (){},
                                )/*Text('体重 58.7 kg')*/,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 180, right: 25),
                                child: Divider(indent: 280,color: GTheme.Colors.mainColor,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 35),
                        child: Divider(
                          indent: 35.0,
                        ),
                      ),
                      FlatButton(
                        child: Text('检测设备运行正常'),
                        color: Color.fromRGBO(119, 180, 245, 0.3),
                        textColor: GTheme.Colors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}