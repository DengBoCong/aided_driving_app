import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("关于陌梦车载", style: TextStyle(color: GTheme.Colors.textColorB),),
        backgroundColor: GTheme.Colors.mainBackColor,
        iconTheme: IconThemeData(color: GTheme.Colors.textColorB),
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset('assets/images/about_logo.png', width: 70,height: 70,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text("陌梦车载", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text("2.6.6.1", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text("检查更新", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text("给我们评分", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text("版本介绍", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 15),textAlign: TextAlign.start,),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("                    服务条款", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("|", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("许可协议", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("|", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("隐私政策", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("|", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                        Text("权力声明                    ", style: TextStyle(color: GTheme.Colors.aboutLogoColor,fontSize: 13),),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Amazing团队 版权所有", style: TextStyle(color: Colors.grey, fontSize: 11),),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("CopyRight©2018-2019 Amazing.All Rights Reserved", style: TextStyle(color: Colors.grey, fontSize: 11),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}