import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/tab/bubble_tab_indicator.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class MyMessagePage extends StatefulWidget{
  MyMessagePage({Key key}) : super(key : key);

  MyMessagePageState createState() => MyMessagePageState();
}

class MyMessagePageState extends State<MyMessagePage> with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    new Tab(text: "私信",),
    new Tab(text: "反馈",),
    new Tab(text: "@我",),
    new Tab(text: "通知",),
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
        title: Text("我的消息", textAlign: TextAlign.left,),
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
        children: tabs.map((Tab tab){
          return Center(
            child: Text(
              tab.text,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}