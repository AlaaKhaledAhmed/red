import 'package:flutter/cupertino.dart';

class AppClipperDarkBlueContainer extends CustomClipper<Path>{
 @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 800;
    path.lineTo(96.6818 * _xScaling,14.3382 * _yScaling);
    path.cubicTo(105.263 * _xScaling,42.0525 * _yScaling,80.475 * _xScaling,70.7751 * _yScaling,59.0425 * _xScaling,92.7218 * _yScaling,);
    path.cubicTo(43.4804 * _xScaling,108.657 * _yScaling,18.2617 * _xScaling,104.765 * _yScaling,-1.67656 * _xScaling,115.056 * _yScaling,);
    path.cubicTo(-28.6256 * _xScaling,128.966 * _yScaling,-45.7893 * _xScaling,165.049 * _yScaling,-75.3924 * _xScaling,162.113 * _yScaling,);
    path.cubicTo(-107.59 * _xScaling,158.919 * _yScaling,-138.266 * _xScaling,132.17 * _yScaling,-141.517 * _xScaling,101.187 * _yScaling,);
    path.cubicTo(-144.635 * _xScaling,71.4786 * _yScaling,-105.978 * _xScaling,54.1753 * _yScaling,-89.4794 * _xScaling,27.8675 * _yScaling,);
    path.cubicTo(-75.7923 * _xScaling,6.04303 * _yScaling,-78.1009 * _xScaling,-25.7792 * _yScaling,-54.5886 * _xScaling,-37.4239 * _yScaling,);
    path.cubicTo(-30.1188 * _xScaling,-49.5429 * _yScaling,-3.0897 * _xScaling,-35.8322 * _yScaling,21.8842 * _xScaling,-27.2866 * _yScaling,);
    path.cubicTo(50.262 * _xScaling,-17.5762 * _yScaling,88.0655 * _xScaling,-13.4893 * _yScaling,96.6818 * _xScaling,14.3382 * _yScaling,);
    path.cubicTo(96.6818 * _xScaling,14.3382 * _yScaling,96.6818 * _xScaling,14.3382 * _yScaling,96.6818 * _xScaling,14.3382 * _yScaling,);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=>true;

  
}