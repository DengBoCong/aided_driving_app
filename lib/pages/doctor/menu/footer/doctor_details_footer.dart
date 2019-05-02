import 'package:flutter/material.dart';
import 'package:aided_driving_app/pages/doctor/menu/footer/articles_showcase.dart';
import 'package:aided_driving_app/pages/doctor/menu/footer/portfolio_showcase.dart';
import 'package:aided_driving_app/pages/doctor/menu/footer/skills_showcase.dart';
import 'package:aided_driving_app/data/classes/doctor.dart';

class DoctorShowcase extends StatefulWidget{
  DoctorShowcase(this.doctor);

  final Doctor doctor;

  @override
  _DoctorShowcaseState createState() => new _DoctorShowcaseState();
}

class _DoctorShowcaseState extends State<DoctorShowcase>
    with TickerProviderStateMixin{
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = [
      new Tab(text: '个人展示',),
      new Tab(text: '能力',),
      new Tab(text: '文章',),
    ];
    _pages = [
      new PortfolioShowcase(),
      new SkillsShowcase(),
      new ArticlesShowcase(),
    ];

    _controller = new TabController(length: _tabs.length, vsync: this,);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              children: _pages,
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}