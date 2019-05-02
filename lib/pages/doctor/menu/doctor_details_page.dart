import 'package:flutter/material.dart';
import 'package:aided_driving_app/pages/doctor/menu/footer/doctor_details_footer.dart';
import 'package:aided_driving_app/pages/doctor/menu/doctor_details_body.dart';
import 'package:aided_driving_app/pages/doctor/menu/header/doctor_details_header.dart';
import 'package:aided_driving_app/data/classes/doctor.dart';
import 'package:aided_driving_app/data/theme.dart' as GTheme;

class DoctorDetailsPage extends StatefulWidget{
  DoctorDetailsPage(
    this.doctor,{
    this.avatarTag,
  });

  final Doctor doctor;
  final Object avatarTag;

  @override
  _DoctorDetailsPageState createState() => new _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          GTheme.Colors.doctorBack,
          GTheme.Colors.loginGradientStart,
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new DoctorDetailsHeader(
                widget.doctor,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new DoctorDetailsBody(widget.doctor),
              ),
              new DoctorShowcase(widget.doctor),
            ],
          ),
        ),
      ),
    );
  }
}