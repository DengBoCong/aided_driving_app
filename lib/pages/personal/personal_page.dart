import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class PersonalPage extends StatefulWidget{
  PersonalPage({Key key}) : super(key : key);

  @override
  PersonalPageState createState() => new PersonalPageState();
}

class PersonalPageState extends State<PersonalPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[

        ],
        elevation: 0,
        backgroundColor: Color(0xFFF4F4F4),
        textTheme: TextTheme(
          title: TextStyle(
            color: GTheme.Colors.textColorB,
            fontSize: 20.0,
          ),
        ),
        iconTheme: IconThemeData(
          color: GTheme.Colors.textColorB,
        ),
        title: Text("个人中心", textAlign: TextAlign.left,),
      ),
      body: Container(
        color: Color(0xFFF4F4F4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8,left: 16,right: 16),
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: new AssetImage('assets/images/person.jpg'),
                      /*Icon(Icons.person,color: Colors.white,size: 40)*/
                      backgroundColor: Colors.grey,
                      radius: 40,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 16, right: 16),
              child: Container(
                height: 30,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("林沫  ", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 17),),
                    Text("  LV1", style: TextStyle(color: GTheme.Colors.loginGradientStart, fontSize: 13),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1, left: 16, right: 16),
              child: Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text("活动中心\n完成任务领取奖励"),
                          onPressed: (){},
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text("会员中心\n畅享海量医师建议"),
                          onPressed: (){},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Container(
                height: 130,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          child: Text("智能标签", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 16),),
                        ),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: FlatButton(
                            child: Text("高速老司机"),
                            shape: Border(
                              top: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              left: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              right: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              bottom: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: FlatButton(
                            child: Text("交规卫士"),
                            shape: Border(
                              top: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              left: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              right: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              bottom: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: FlatButton(
                            child: Text("文明驾驶"),
                            shape: Border(
                              top: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              left: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              right: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              bottom: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: FlatButton(
                            child: Text("健康达人"),
                            shape: Border(
                              top: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              left: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              right: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              bottom: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: FlatButton(
                            child: Text("驾轻就熟"),
                            shape: Border(
                              top: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              left: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              right: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                              bottom: BorderSide(width: 1,color: Color(0xFFF4F4F4)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Container(
                height: 180,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          child: Text("个人设置", style: TextStyle(color: GTheme.Colors.textColorB, fontSize: 16),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: ListTile(
                        title:  Text("紧急联系人"),
                        leading: Image(image: AssetImage("assets/images/person.jpg"),width: 50,height: 50,),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ListTile(
                        title:  Text("实时健康医师"),
                        leading: Image(image: AssetImage("assets/images/person.jpg"),width: 50,height: 50,),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset("assets/images/identify_personal.png"),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Image.asset("assets/images/identify_enterprise.png"),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 16, right: 16),
              child: Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("实名认证"),
                    Text("医师认证"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("查看个人详细资料"),
                    shape: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}