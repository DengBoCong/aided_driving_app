import 'package:flutter/material.dart';
import 'package:aided_driving_app/data/classes/doctor.dart';
import 'package:aided_driving_app/pages/doctor/menu/header/diagonally_cut_colored_image.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class DoctorDetailsHeader extends StatelessWidget{
  static const BACKGROUND_IMAGE = 'assets/images/profile_header_background.png';

  DoctorDetailsHeader(
      this.doctor,{
      this.avatarTag,
  });

  final Doctor doctor;
  final Object avatarTag;

  Widget _buildDiagonalImageBackground(BuildContext context){
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      new Image.asset(
        BACKGROUND_IMAGE,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: GTheme.Colors.mainColorTran,
    );
  }

  Widget _buildAvatar(){
    return new Hero(
      tag: avatarTag,
      child: new CircleAvatar(
        backgroundImage: new AssetImage('assets/images/person.jpg'),
        radius: 50.0,
      ),
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme){
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('90 关注', style: followerStyle,),
          new Text(
            ' | ',
            style: followerStyle.copyWith(
              fontSize: 24.0, fontWeight: FontWeight.normal
            ),
          ),
          new Text('100 案例', style: followerStyle,),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme){
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _createPillButton(
            '关注',
            backgroundColor: theme.accentColor,
          ),
          _createPillButton(
            '咨询',
            backgroundColor: GTheme.Colors.loginGradientEnd,
          ),
        ],
      ),
    );
  }

  Widget _createPillButton(
      String text,{
        Color backgroundColor = Colors.transparent,
        Color textColor = Colors.white70,
      }){
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: new Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
              _buildActionButtons(theme),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white,),
        ),
      ],
    );
  }
}