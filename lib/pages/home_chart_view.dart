import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;
import 'package:aided_driving_app/pages/message/my_message_page.dart';
import 'package:aided_driving_app/pages/doctor/private_doctor_page.dart';
import 'package:aided_driving_app/pages/home_text_view.dart';
import 'package:aided_driving_app/utils/blank_fade_route.dart';
import 'package:aided_driving_app/pages/report/report_page.dart';
import 'package:aided_driving_app/pages/wallet/wallet_page.dart';
import 'package:aided_driving_app/pages/household/household_page.dart';
import 'package:aided_driving_app/pages/driving/driving_page.dart';
import 'package:aided_driving_app/pages/healthy/healthy_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aided_driving_app/utils/tts/tts_helper.dart';
import 'package:aided_driving_app/pages/about/about_page.dart';
import 'package:aided_driving_app/pages/device/device_page.dart';
import 'package:aided_driving_app/pages/guide/guide_page.dart';
import 'package:aided_driving_app/pages/help/help_page.dart';
import 'package:aided_driving_app/pages/personal/personal_page.dart';
import 'package:flutter/services.dart';

class HomeChartViewPage extends StatelessWidget
{
  void enterAI() async{
    const platform = const MethodChannel("com.power/AI");
    try{
      await platform.invokeMethod("enterIvwActivity");
    } on PlatformException catch(e){
      print(e.toString());
    }
  }

  Widget call(){
    return Container(
      child: FloatingActionButton(
        heroTag: "callButton",
        backgroundColor: GTheme.Colors.mainColor,
        onPressed: (){_launchPhone();},
        tooltip: '呼叫紧急联系人',
        child: Icon(Icons.call, color: GTheme.Colors.iconColor,),
      ),
    );
  }

  _launchPhone() async {
    const url = 'tel:18870125082';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget driving(){
    return Container(
      child: FloatingActionButton(
        heroTag: "drivingButton",
        backgroundColor: GTheme.Colors.mainColor,
        onPressed: (){
          /*TtsHelper.instance.setLanguageAndSpeak("你好主人，我是小沫，很荣幸能为你服务", "zh");*/
          enterAI();
        },
        tooltip: '驾车模式',
        child: Icon(Icons.drive_eta, color: GTheme.Colors.iconColor,),
      ),
    );
  }

  Widget textView(BuildContext context){
    return Container(
      child: FloatingActionButton(
        heroTag: "shareButton",
        backgroundColor: GTheme.Colors.mainColor,
        onPressed: () => Navigator.of(context).push(FadeRoute(HomeTextViewPage())),
        tooltip: '文字模式',
        child: Icon(Icons.assignment, color: GTheme.Colors.iconColor,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inner Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MyHomePage(title: '陌梦'),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            call(),
            driving(),
            textView(context),
          ],
          colorEndAnimation: Colors.red,
          colorStartAnimation: GTheme.Colors.mainColor,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/myMessage' : (BuildContext context) => MyMessagePage(),
        '/privateDoctor' : (BuildContext context) => PrivateDoctorPage(),
        '/healthyReport' : (BuildContext context) => ReportPage(),
        '/myWallet' : (BuildContext context) => WalletPage(),
        '/about' : (BuildContext context) => AboutPage(),
        '/device' : (BuildContext context) => DevicePage(),
        '/guide' : (BuildContext context) => GuidePage(),
        '/help' : (BuildContext context) => HelpPage(),
        '/personal' : (BuildContext context) => PersonalPage(),
      },
    );
  }
}


class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
{
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  GlobalKey _keyRed = GlobalKey();
  double _width=10;
  double _offset = 0.4;
  int currentPage;


  @override
  void initState()
  {
    super.initState();
    _getwidthContainer();
    currentPage = 0;
  }

  void _getwidthContainer()
  {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject ( );
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    _getwidthContainer();

    return InnerDrawer(
      key: _innerDrawerKey,
      position: InnerDrawerPosition.start,
      onTapClose: true,
      offset: 0.4,
      swipe: true,
      colorTransition: Colors.black54,
      animationType: InnerDrawerAnimation.quadratic,
      //innerDrawerCallback: (a) => print(a),
      child: Material(
          child:  SafeArea(
            //top: false,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1, color: Colors.grey[200]),
                      right: BorderSide(width: 1, color: Colors.grey[200])
                  ),
                ),
                child: Stack(
                  key: _keyRed,
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top:12,bottom: 4, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 45,
                                      height: 45,
                                      child: IconButton(
                                          icon: CircleAvatar(
                                            backgroundImage: new AssetImage('assets/images/person.jpg'),
                                            /*Icon(Icons.person,color: Colors.white,size: 40)*/
                                            backgroundColor: Colors.grey,
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).pushNamed("/personal");
                                          }
                                      ),
                                    ),
                                    Text("   林沫",
                                      style: TextStyle(fontWeight: FontWeight.w600, height: 1.2),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:2, right: 25),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 18,),
                                    onTap: ()
                                    {
                                      _innerDrawerKey.currentState.close();
                                    },
                                  ),
                                ),
                              ],
                            )
                        ),
                        Divider(),
                        ListTile(
                          title:  Text("我的消息"),
                          leading:Icon(Icons.email),
                          trailing: Icon(Icons.add),
                          onTap: () => Navigator.of(context).pushNamed('/myMessage'),
                        ),
                        ListTile(
                          title:   Text("我的钱包"),
                          leading: Icon(Icons.monetization_on),
                          trailing: Icon(Icons.assignment),
                          onTap: () => Navigator.of(context).pushNamed('/myWallet'),
                        ),
                        ListTile(
                          title:   Text("智能周报"),
                          leading: Icon(Icons.assignment),
                          subtitle: Text("6sa"),
                          trailing: Icon(Icons.access_alarm),
                          onTap: () => Navigator.of(context).pushNamed('/healthyReport'),
                        ),
                        ListTile(
                          title:   Text("私人医生"),
                          leading: Icon(Icons.perm_contact_calendar),
                          trailing: Icon(Icons.access_alarm),
                          onTap: () => Navigator.of(context).pushNamed('/privateDoctor'),
                        ),
                        Divider(),
                        ListTile(
                          title:   Text("设备管理"),
                          leading: Icon(Icons.screen_lock_portrait),
                          trailing: Icon(Icons.access_alarm),
                          onTap: () => Navigator.of(context).pushNamed('/device'),
                        ),
                        ListTile(
                          title: Text("云端同步"),
                          leading: Icon(Icons.cloud_upload),
                        ),
                        ListTile(
                          title:   Text("娱乐咨询"),
                          leading: Icon(Icons.live_tv),
                        ),
                        ListTile(
                          title:   Text("智能导航"),
                          leading: Icon(Icons.person_pin_circle),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("新手指南"),
                          leading: Icon(Icons.lightbulb_outline),
                          onTap: () => Navigator.of(context).pushNamed('/guide'),
                        ),
                        ListTile(
                          title: Text("帮助与反馈"),
                          leading: Icon(Icons.contact_mail),
                          onTap: () => Navigator.of(context).pushNamed('/help'),
                        ),
                        ListTile(
                          title: Text("关于陌梦车载"),
                          leading: Icon(Icons.error_outline),
                          trailing: Icon(Icons.access_alarm),
                          onTap: () => Navigator.of(context).pushNamed('/about'),
                        )
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                          width: _width,
                          decoration: BoxDecoration(
                            //color: Colors.grey,
                              border: Border(top: BorderSide(color: Colors.grey[200],))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.settings,size: 18,),
                                  Text("  设置",
                                    style: TextStyle( fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.exit_to_app,size: 18,),
                                  Text("  退出",
                                    style: TextStyle( fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          )
                        )
                    )
                  ],
                ),
              )
          )
      ),
      scaffold: Scaffold(
          appBar: CupertinoNavigationBar(
            middle: Text(widget.title),
            automaticallyImplyLeading: false,
            leading: IconButton(
              color: Colors.transparent,
              icon: CircleAvatar(
                backgroundImage: new AssetImage('assets/images/person.jpg'),
              ),
              iconSize: 24,
              onPressed: (){
                _innerDrawerKey.currentState.open();
              },
            ),
            backgroundColor: Colors.grey[50],
            trailing: Icon(
              Icons.filter_center_focus,
              size: 25,
            ),
          ),
          bottomNavigationBar: FancyBottomNavigation(
              tabs: [
                TabData(iconData: Icons.drive_eta, title: "驾驶情况"),
                TabData(iconData: Icons.assignment_ind, title: "健康情况"),
                TabData(iconData: Icons.important_devices, title: "实时管家")
              ],
              circleColor: GTheme.Colors.mainColor,
              textColor: GTheme.Colors.mainColor,
              inactiveIconColor: GTheme.Colors.mainColor,
              onTabChangedListener: (position){
                setState(() {
                  currentPage = position;
                });
              },
          ),
          body: SafeArea(
              child: _buildTabPage(currentPage),
          )

      ),
    );
  }

  Widget _buildTabPage(int poisition){
    if(poisition == 0){
      return Material(
        child: DrivingPage(),
      );
    } else if(poisition == 1){
      return HealthyPage();
    } else{
      return Material(
        child: HouseholdPage(),
      );
    }
  }

}
