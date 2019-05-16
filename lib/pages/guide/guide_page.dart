import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class GuidePage extends StatelessWidget{
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      bubble: Image.asset('assets/images/hostess.png'),
      body: Text('欢迎使用新手指南'),
      title: Text(
        '新手指南',
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Image.asset(
        'assets/images/airplane.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/images/waiter.png',
      body: Text(
        '欢迎使用新手指南',
      ),
      title: Text('新手指南'),
      mainImage: Image.asset(
        'assets/images/hotel.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/images/taxi-driver.png',
      body: Text(
        '欢迎使用新手指南',
      ),
      title: Text('新手指南'),
      mainImage: Image.asset(
        'assets/images/taxi.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: (){},
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}