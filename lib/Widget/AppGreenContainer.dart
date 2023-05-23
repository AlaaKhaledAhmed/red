import 'package:flutter/cupertino.dart';

class AppClipperGreenContainer extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 320;
    final double _yScaling = size.height / 700;
    path.lineTo(4.38817 * _xScaling,5.45547 * _yScaling);
    path.cubicTo(-6.85866 * _xScaling,-14.7384 * _yScaling,8.98794 * _xScaling,-33.9914 * _yScaling,17.3439 * _xScaling,-50.64 * _yScaling,);
    path.cubicTo(22.9519 * _xScaling,-61.8134 * _yScaling,33.5075 * _xScaling,-65.6236 * _yScaling,43.1695 * _xScaling,-71.8132 * _yScaling,);
    path.cubicTo(54.2526 * _xScaling,-78.9131 * _yScaling,62.8026 * _xScaling,-92.9737 * _yScaling,77.0118 * _xScaling,-88.864 * _yScaling,);
    path.cubicTo(92.639 * _xScaling,-84.3441 * _yScaling,105.34 * _xScaling,-67.3893 * _yScaling,115.685 * _xScaling,-50.8395 * _yScaling,);
    path.cubicTo(127.842 * _xScaling,-31.3905 * _yScaling,143.917 * _xScaling,-8.39552 * _yScaling,139.373 * _xScaling,10.9007 * _yScaling,);
    path.cubicTo(134.872 * _xScaling,30.0139 * _yScaling,113.053 * _xScaling,30.196 * _yScaling,96.0188 * _xScaling,32.6717 * _yScaling,);
    path.cubicTo(83.7405 * _xScaling,34.4561 * _yScaling,71.301 * _xScaling,26.5936 * _yScaling,58.1897 * _xScaling,22.6993 * _yScaling,);
    path.cubicTo(39.5397 * _xScaling,17.1599 * _yScaling,15.7528 * _xScaling,25.8609 * _yScaling,4.38817 * _xScaling,5.45547 * _yScaling,);
    path.cubicTo(4.38817 * _xScaling,5.45547 * _yScaling,4.38817 * _xScaling,5.45547 * _yScaling,4.38817 * _xScaling,5.45547 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=>true;

}