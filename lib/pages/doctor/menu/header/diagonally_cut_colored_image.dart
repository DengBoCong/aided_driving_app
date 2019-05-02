import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DiagonallyCutColoredImage extends StatelessWidget{
  DiagonallyCutColoredImage(this.image, {this.color});

  final Image image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ClipPath(
      clipper: new DiagonalClipper(),
      child: new DecoratedBox(
        decoration: new BoxDecoration(color: color),
        position: DecorationPosition.foreground,
        child: image,
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - 50.0);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}