import 'package:flutter/cupertino.dart';

class AppClipperBlueContainer extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 250;
    final double _yScaling = size.height / 700;
    path.lineTo(90.8278 * _xScaling,25.2364 * _yScaling);
    path.cubicTo(73.883 * _xScaling,31.3419 * _yScaling,63.5383 * _xScaling,50.4435 * _yScaling,45.6167 * _xScaling,49.5454 * _yScaling,);
    path.cubicTo(29.5275 * _xScaling,48.7391 * _yScaling,27.1729 * _xScaling,31.8985 * _yScaling,19.9484 * _xScaling,21.6843 * _yScaling,);
    path.cubicTo(13.2708 * _xScaling,12.2434 * _yScaling,2.20942 * _xScaling,3.22817 * _yScaling,5.00342 * _xScaling,-7.87471 * _yScaling,);
    path.cubicTo(7.76538 * _xScaling,-18.8503 * _yScaling,21.5549 * _xScaling,-27.2334 * _yScaling,34.0092 * _xScaling,-34.1911 * _yScaling,);
    path.cubicTo(43.7605 * _xScaling,-39.6388 * _yScaling,57.0747 * _xScaling,-37.8358 * _yScaling,67.3351 * _xScaling,-42.697 * _yScaling,);
    path.cubicTo(79.6087 * _xScaling,-48.5119 * _yScaling,84.6023 * _xScaling,-62.2572 * _yScaling,98.4333 * _xScaling,-64.7137 * _yScaling,);
    path.cubicTo(112.253 * _xScaling,-67.1682 * _yScaling,123.883 * _xScaling,-59.4623 * _yScaling,135.651 * _xScaling,-54.8302 * _yScaling,);
    path.cubicTo(149.911 * _xScaling,-49.2167 * _yScaling,167.575 * _xScaling,-45.6936 * _yScaling,174.37 * _xScaling,-34.8213 * _yScaling,);
    path.cubicTo(181.412 * _xScaling,-23.5538 * _yScaling,181.976 * _xScaling,-8.11684 * _yScaling,171.903 * _xScaling,3.17649 * _yScaling,);
    path.cubicTo(161.865 * _xScaling,14.4312 * _yScaling,141.329 * _xScaling,16.5471 * _yScaling,124.461 * _xScaling,21.1368 * _yScaling,);
    path.cubicTo(113.387 * _xScaling,24.15 * _yScaling,101.516 * _xScaling,21.3854 * _yScaling,90.8278 * _xScaling,25.2364 * _yScaling,);
    path.cubicTo(90.8278 * _xScaling,25.2364 * _yScaling,90.8278 * _xScaling,25.2364 * _yScaling,90.8278 * _xScaling,25.2364 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=>true;
}