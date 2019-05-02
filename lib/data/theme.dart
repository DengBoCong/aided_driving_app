import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color(0xAF2ACFFF);
  static const Color loginGradientEnd = const Color(0xAF3992F1);

  static const Color mainColor = const Color(0xFF77B4F5);
  static const Color iconColor = const Color(0xFFFFFFFF);

  static const Color mainColorTran = const Color(0x8F77B4F5);
  static const Color iconColorTran = const Color(0xAFFFFFFF);

  static const Color textColorB = const Color(0xFF313335);
  static const Color doctorBack = const Color(0xAF4772FD);/*2F5FFE*/
  
  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}