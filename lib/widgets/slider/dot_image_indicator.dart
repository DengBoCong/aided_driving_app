import 'dart:math';
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget{
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color,
  }) : super(listenable: controller);

  final PageController controller;

  final int itemCount;

  final ValueChanged<int> onPageSelected;

  final Color color;

  static const double _kDotSize = 4.0;

  static const double _kMaxZoom = 2.0;

  static const double _kDotSpacing = 15.0;

  Widget _buildDot(int index){
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );

    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}