import 'package:flutter/material.dart';
import 'package:aided_driving_app/utils/villain.dart';
import 'package:aided_driving_app/utils/blank_fade_route.dart';
import 'package:aided_driving_app/widgets/tab/bubble_tab_indicator.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/utils/villain.dart';
import 'package:aided_driving_app/utils/blank_fade_route.dart';

class HomeTextViewPage extends StatefulWidget{
  HomeTextViewPage({Key key}) : super(key : key);

  @override
  _HomeTextViewPageState createState() => new _HomeTextViewPageState();
}

class _HomeTextViewPageState extends State<HomeTextViewPage>
    with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    new Tab(text: "驾驶数据",),
    new Tab(text: "健康数据",),
  ];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: GTheme.Colors.iconColor,
        textTheme: TextTheme(
          title: TextStyle(
            color: GTheme.Colors.textColorB,
            fontSize: 20.0,
          ),
        ),
        iconTheme: IconThemeData(
          color: GTheme.Colors.textColorB,
        ),
        title: Text("陌梦", textAlign: TextAlign.left,),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: GTheme.Colors.textColorB,
          labelColor: GTheme.Colors.iconColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            indicatorHeight: 25.0,
            indicatorColor: GTheme.Colors.mainColor,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DrivingDataPage(),
          HealthyDataPage(),
        ],
      ),
    );
  }
}

/*tabs.map((Tab tab){
          return Center(
            child: Text(
              tab.text,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }).toList(),*/

class DrivingDataPage extends StatefulWidget{
  @override
  _DrivingDataPageState createState() => new _DrivingDataPageState();
}

class _DrivingDataPageState extends State<DrivingDataPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xffECECEE),
      body: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Villain(
                  animateEntrance: false,
                  villainAnimation: VillainAnimation.fade(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: "林沫",
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/person.jpg'),
                          radius: 50.0,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.4, to: Duration(milliseconds: 150)),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Text(
                          "根据设备检测的健康数据显示，您当前体温为39.3℃，当前体重为64.7kg，当前心率为73次/分，当前血压为121/79每毫米汞柱，当前血脂为4.9mmol/L，综合健康指数分值为88分，需要注意的是您的血脂在正常范围内偏高，平时请注意饮食锻炼。存在健康隐患，详情请至咨询模块询问，或前往医院咨询。",
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                        ),
                      ),
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.4),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Divider(
                          color: Colors.black,
                          height: 32.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 100), to: Duration(milliseconds: 250)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("驾驶评级:", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 18.0),)),
                              decoration: BoxDecoration(shape: BoxShape.rectangle),
                              width: 120.0,
                              height: 32.0,
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 100), to: Duration(milliseconds: 250)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("A", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffea4c89)),
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 150), to: Duration(milliseconds: 300)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Container(
                                child: Center(child: Text("B", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                width: 32.0,
                                height: 32.0,
                              ),
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 200), to: Duration(milliseconds: 350)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("C", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                        "                                "
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.green,
                    ),
                    Text(
                      " 设备正常  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: GTheme.Colors.textColorB,
                      ),
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.red,
                    ),
                    Text(
                      "  设备故障  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: GTheme.Colors.textColorB,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
              child: Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "    详细驾驶数据    ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18,
                          color: GTheme.Colors.textColorB,
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Villain(
              villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.05, from: Duration(milliseconds: 300), to: Duration(milliseconds: 400)),
              secondaryVillainAnimation: VillainAnimation.fade(),
              child: Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("车道线 实线碾压次数 共 6 次"),
                        subtitle: Text("超过87.30%同驾龄司机"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("交通信号灯 闯红灯次数 共 0 次"),
                        subtitle: Text("超过99.99%同驾龄司机"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("保持车辆安全距离 评分 97.36 分"),
                        subtitle: Text("超过87.69%同驾龄司机"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("礼让行人 评分 93.36 分"),
                        subtitle: Text("超过91.69%同驾龄司机"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("驾驶路段 超速次数 共 13 次"),
                        subtitle: Text("超过52.69%同驾龄司机"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HealthyDataPage extends StatefulWidget{
  @override
  _HealthyDataPageState createState() => new _HealthyDataPageState();
}

class _HealthyDataPageState extends State<HealthyDataPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xffECECEE),
      body: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Villain(
                  animateEntrance: false,
                  villainAnimation: VillainAnimation.fade(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: "林沫",
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/person.jpg'),
                          radius: 50.0,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.4, to: Duration(milliseconds: 150)),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Text(
                          "根据设备检测的健康数据显示，您当前体温为39.3℃，当前体重为64.7kg，当前心率为73次/分，当前血压为121/79每毫米汞柱，当前血脂为4.9mmol/L，综合健康指数分值为88分，需要注意的是您的血脂在正常范围内偏高，平时请注意饮食锻炼。存在健康隐患，详情请至咨询模块询问，或前往医院咨询。",
                          style: Theme
                              .of(context)
                              .textTheme
                              .body1,
                        ),
                      ),
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.4),
                        animateExit: false,
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Divider(
                          color: Colors.black,
                          height: 32.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 100), to: Duration(milliseconds: 250)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("健康评级:", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 18.0),)),
                              decoration: BoxDecoration(shape: BoxShape.rectangle),
                              width: 120.0,
                              height: 32.0,
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 100), to: Duration(milliseconds: 250)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("A", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffea4c89)),
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 150), to: Duration(milliseconds: 300)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Container(
                                child: Center(child: Text("B", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                width: 32.0,
                                height: 32.0,
                              ),
                            ),
                          ),
                          Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.8, curve: Curves.fastOutSlowIn, from: Duration(milliseconds: 200), to: Duration(milliseconds: 350)),
                            secondaryVillainAnimation: VillainAnimation.fade(),
                            animateExit: false,
                            child: Container(
                              child: Center(child: Text("C", style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                              width: 32.0,
                              height: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      "                                "
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.green,
                    ),
                    Text(
                      " 设备正常  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: GTheme.Colors.textColorB,
                      ),
                    ),
                    Icon(
                      Icons.brightness_1,
                      color: Colors.red,
                    ),
                    Text(
                      "  设备故障  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: GTheme.Colors.textColorB,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      "    详细健康数据    ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color: GTheme.Colors.textColorB,
                      ),
                    ),
                  ],
                )
              ),
            ),
            Villain(
              villainAnimation: VillainAnimation.fromBottom(relativeOffset: 0.05, from: Duration(milliseconds: 300), to: Duration(milliseconds: 400)),
              secondaryVillainAnimation: VillainAnimation.fade(),
              child: Card(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("心率 83次/分"),
                        subtitle: Text("心跳属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("血压 121/79每毫米汞柱"),
                        subtitle: Text("体温属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("体重 59.3kg"),
                        subtitle: Text("体重属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.red,
                        ),
                      ),
                      ListTile(
                        title: Text("体温 37.6℃"),
                        subtitle: Text("体温属于正常范围"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("血脂 4.9mmol/L"),
                        subtitle: Text("血脂属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("疲劳指数 3.8"),
                        subtitle: Text("疲劳指数属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                      ListTile(
                        title: Text("血氧饱和度 90%"),
                        subtitle: Text("血氧饱和度属于正常范围内"),
                        trailing: Icon(
                          Icons.brightness_1,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}