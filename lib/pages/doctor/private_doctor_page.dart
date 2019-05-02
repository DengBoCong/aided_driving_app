import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/pages/doctor/menu/doctor_menu_page.dart';

class PrivateDoctorPage extends StatefulWidget{
  PrivateDoctorPage({Key key}) : super(key : key);

  @override
  _PrivateDoctorPageState createState() => new _PrivateDoctorPageState();
}

class _PrivateDoctorPageState extends State<PrivateDoctorPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          title: Text("私人医生", textAlign: TextAlign.left,),
        ),
        body: Scaffold(
          appBar: ShiftingTabBar(
            color: GTheme.Colors.iconColor,
            labelStyle: TextStyle(
              color: GTheme.Colors.mainColor,
              fontSize: 17,
            ),
            tabs: [
              ShiftingTab(
                icon: Icon(Icons.account_balance),
                text: "医生列表",
              ),
              ShiftingTab(
                icon: Icon(Icons.favorite_border),
                text: "我的关注",
              ),
              ShiftingTab(
                icon: Icon(Icons.person_pin),
                text: "私人医生",
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              DoctorMenuPage(),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}