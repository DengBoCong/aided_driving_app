import 'package:flutter/material.dart';
import 'package:aided_driving_app/widgets/dropdown_menu/dropdown_menu.dart';
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:aided_driving_app/data/classes/doctor.dart';
import 'package:aided_driving_app/pages/doctor/menu/doctor_details_page.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/widgets/slider/simple_widget_slider.dart';
import 'package:aided_driving_app/pages/report/report_item.dart';
import 'package:share/share.dart';

class ReportPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              shareNotice();
            },
            color: GTheme.Colors.textColorB,
          )
        ],
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
        title: Text("智能周报", textAlign: TextAlign.left,),
      ),
      body: new ReportContext(),
    );
  }

  Future shareNotice() async {
    await Share.share("生成报告");
  }
}


class ReportContext extends StatefulWidget{
  ReportContext({Key key}) : super(key: key);

  @override
  _ReportContextState createState() => new _ReportContextState();
}

const List<Map<String, dynamic>> ORDERS = [
  {"title" : "全部"},
  {"title" : "1月"},
  {"title" : "2月"},
  {"title" : "3月"},
  {"title" : "4月"},
  {"title" : "5月"},
  {"title" : "6月"},
  {"title" : "7月"},
  {"title" : "8月"},
  {"title" : "9月"},
  {"title" : "10月"},
  {"title" : "11月"},
  {"title" : "12月"},
];

const int ORDER_INDEX = 0;

const List<Map<String, dynamic>> TYPES = [
  {"title": "全部", "id": 0},
  {"title": "2019年", "id": 1},
  {"title": "2018年", "id": 2},
];

const int TYPE_INDEX = 1;

const List<Map<String, dynamic>> FOODS = [
  {"title": "全部"},
  {"title": "驾驶周报"},
  {"title": "健康周报"},
];

const int FOOD_INDEX = 0;

class _ReportContextState extends State<ReportContext>{
  ScrollController _scrollController;
  SlidableController _slidableController;

  final _widgets = [
    ReportItem(),
    ReportItem(),
    ReportItem(),
    ReportItem(),
    ReportItem(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = new ScrollController();
    globalKey = new GlobalKey();
    _slidableController = new SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  DropdownMenu buildDropdownMenu(){
    return new DropdownMenu(
      maxMenuHeight: kDropdownMenuItemHeight * 10,
      menus: [
        new DropdownMenuBuilder(
            builder: (BuildContext context){
              return new DropdownListMenu(
                selectedIndex: TYPE_INDEX,
                data: TYPES,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * TYPES.length
        ),
        new DropdownMenuBuilder(
            builder: (BuildContext context){
              return DropdownListMenu(
                selectedIndex: ORDER_INDEX,
                data: ORDERS,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * ORDERS.length
        ),
        new DropdownMenuBuilder(
            builder: (BuildContext context){
              return DropdownListMenu(
                selectedIndex: FOOD_INDEX,
                data: FOODS,
                itemBuilder: buildCheckItem,
              );
            },
            height: kDropdownMenuItemHeight * FOODS.length
        ),
      ],
    );
  }

  DropdownHeader buildDropdownHeader({DropdownMenuHeadTapCallback onTap}){
    return new DropdownHeader(
      onTap: onTap,
      titles: [TYPES[TYPE_INDEX], ORDERS[ORDER_INDEX], FOODS[FOOD_INDEX]],
    );
  }

  Widget buildInnerListHeaderDropdownMenu(){
    return new DefaultDropdownMenuController(
      onSelected: ({int menuIndex, int index, int subIndex, dynamic data}){
        print(
            "menuIndex:$menuIndex index:$index subIndex:$subIndex data:$data");
      },
      child: new Stack(
        children: <Widget>[
          new CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              new SliverPersistentHeader(
                delegate: new DropdownSliverChildBuilderDelegate(
                    builder: (BuildContext context){
                      return new Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: buildDropdownHeader(onTap: this._onTapHead),
                      );
                    }
                ),
                pinned: true,
                floating: true,
              ),
              new SliverList(
                key: globalKey,
                delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                      return new Container(
                        color: Color(0xFFF3F3F3),
                        child: WidgetSliderWidget(
                          widgets: _widgets,
                          widgetHeight: 670,
                          imageBorderRadius: BorderRadius.circular(8.0),
                        ),
                      );
                    }, childCount: 1
                ),
              ),
            ],
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 30.0),
            child: buildDropdownMenu(),
          ),
        ],
      ),
    );
  }

  GlobalKey globalKey;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _onTapHead(int index){
    RenderObject renderObject = globalKey.currentContext.findRenderObject();
    DropdownMenuController controller =
    DefaultDropdownMenuController.of(globalKey.currentContext);

    _scrollController.animateTo(_scrollController.offset + renderObject.semanticBounds.height,
        duration: new Duration(milliseconds: 150), curve: Curves.ease)
        .whenComplete((){
      controller.show(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: buildInnerListHeaderDropdownMenu(),
    );
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation){
    setState((){
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen){
    setState((){
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }
}