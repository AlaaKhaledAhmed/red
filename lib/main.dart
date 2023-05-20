import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Positioned(
                  child: ClipPath(
                clipper: DarkBlueClipper(),
                child: Container(
                  color: Colors.red,
                ),
              )),
              Positioned(
                  child: ClipPath(
                clipper: BlueClipper(),
                child: Container(
                  color: Colors.lightBlueAccent,
                ),
              )),
              Positioned(
                  child: ClipPath(
                clipper: GreenClipper(),
                child: Container(
                  color: Colors.greenAccent,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class DarkBlueClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 800;
    path.lineTo(96.6818 * _xScaling, 14.3382 * _yScaling);
    path.cubicTo(
      105.263 * _xScaling,
      42.0525 * _yScaling,
      80.475 * _xScaling,
      70.7751 * _yScaling,
      59.0425 * _xScaling,
      92.7218 * _yScaling,
    );
    path.cubicTo(
      43.4804 * _xScaling,
      108.657 * _yScaling,
      18.2617 * _xScaling,
      104.765 * _yScaling,
      -1.67656 * _xScaling,
      115.056 * _yScaling,
    );
    path.cubicTo(
      -28.6256 * _xScaling,
      128.966 * _yScaling,
      -45.7893 * _xScaling,
      165.049 * _yScaling,
      -75.3924 * _xScaling,
      162.113 * _yScaling,
    );
    path.cubicTo(
      -107.59 * _xScaling,
      158.919 * _yScaling,
      -138.266 * _xScaling,
      132.17 * _yScaling,
      -141.517 * _xScaling,
      101.187 * _yScaling,
    );
    path.cubicTo(
      -144.635 * _xScaling,
      71.4786 * _yScaling,
      -105.978 * _xScaling,
      54.1753 * _yScaling,
      -89.4794 * _xScaling,
      27.8675 * _yScaling,
    );
    path.cubicTo(
      -75.7923 * _xScaling,
      6.04303 * _yScaling,
      -78.1009 * _xScaling,
      -25.7792 * _yScaling,
      -54.5886 * _xScaling,
      -37.4239 * _yScaling,
    );
    path.cubicTo(
      -30.1188 * _xScaling,
      -49.5429 * _yScaling,
      -3.0897 * _xScaling,
      -35.8322 * _yScaling,
      21.8842 * _xScaling,
      -27.2866 * _yScaling,
    );
    path.cubicTo(
      50.262 * _xScaling,
      -17.5762 * _yScaling,
      88.0655 * _xScaling,
      -13.4893 * _yScaling,
      96.6818 * _xScaling,
      14.3382 * _yScaling,
    );
    path.cubicTo(
      96.6818 * _xScaling,
      14.3382 * _yScaling,
      96.6818 * _xScaling,
      14.3382 * _yScaling,
      96.6818 * _xScaling,
      14.3382 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class BlueClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 800;
    path.lineTo(90.8278 * _xScaling, 25.2364 * _yScaling);
    path.cubicTo(
      73.883 * _xScaling,
      31.3419 * _yScaling,
      63.5383 * _xScaling,
      50.4435 * _yScaling,
      45.6167 * _xScaling,
      49.5454 * _yScaling,
    );
    path.cubicTo(
      29.5275 * _xScaling,
      48.7391 * _yScaling,
      27.1729 * _xScaling,
      31.8985 * _yScaling,
      19.9484 * _xScaling,
      21.6843 * _yScaling,
    );
    path.cubicTo(
      13.2708 * _xScaling,
      12.2434 * _yScaling,
      2.20942 * _xScaling,
      3.22817 * _yScaling,
      5.00342 * _xScaling,
      -7.87471 * _yScaling,
    );
    path.cubicTo(
      7.76538 * _xScaling,
      -18.8503 * _yScaling,
      21.5549 * _xScaling,
      -27.2334 * _yScaling,
      34.0092 * _xScaling,
      -34.1911 * _yScaling,
    );
    path.cubicTo(
      43.7605 * _xScaling,
      -39.6388 * _yScaling,
      57.0747 * _xScaling,
      -37.8358 * _yScaling,
      67.3351 * _xScaling,
      -42.697 * _yScaling,
    );
    path.cubicTo(
      79.6087 * _xScaling,
      -48.5119 * _yScaling,
      84.6023 * _xScaling,
      -62.2572 * _yScaling,
      98.4333 * _xScaling,
      -64.7137 * _yScaling,
    );
    path.cubicTo(
      112.253 * _xScaling,
      -67.1682 * _yScaling,
      123.883 * _xScaling,
      -59.4623 * _yScaling,
      135.651 * _xScaling,
      -54.8302 * _yScaling,
    );
    path.cubicTo(
      149.911 * _xScaling,
      -49.2167 * _yScaling,
      167.575 * _xScaling,
      -45.6936 * _yScaling,
      174.37 * _xScaling,
      -34.8213 * _yScaling,
    );
    path.cubicTo(
      181.412 * _xScaling,
      -23.5538 * _yScaling,
      181.976 * _xScaling,
      -8.11684 * _yScaling,
      171.903 * _xScaling,
      3.17649 * _yScaling,
    );
    path.cubicTo(
      161.865 * _xScaling,
      14.4312 * _yScaling,
      141.329 * _xScaling,
      16.5471 * _yScaling,
      124.461 * _xScaling,
      21.1368 * _yScaling,
    );
    path.cubicTo(
      113.387 * _xScaling,
      24.15 * _yScaling,
      101.516 * _xScaling,
      21.3854 * _yScaling,
      90.8278 * _xScaling,
      25.2364 * _yScaling,
    );
    path.cubicTo(
      90.8278 * _xScaling,
      25.2364 * _yScaling,
      90.8278 * _xScaling,
      25.2364 * _yScaling,
      90.8278 * _xScaling,
      25.2364 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class GreenClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 360;
    final double _yScaling = size.height / 800;
    path.lineTo(4.38817 * _xScaling, 5.45547 * _yScaling);
    path.cubicTo(
      -6.85866 * _xScaling,
      -14.7384 * _yScaling,
      8.98794 * _xScaling,
      -33.9914 * _yScaling,
      17.3439 * _xScaling,
      -50.64 * _yScaling,
    );
    path.cubicTo(
      22.9519 * _xScaling,
      -61.8134 * _yScaling,
      33.5075 * _xScaling,
      -65.6236 * _yScaling,
      43.1695 * _xScaling,
      -71.8132 * _yScaling,
    );
    path.cubicTo(
      54.2526 * _xScaling,
      -78.9131 * _yScaling,
      62.8026 * _xScaling,
      -92.9737 * _yScaling,
      77.0118 * _xScaling,
      -88.864 * _yScaling,
    );
    path.cubicTo(
      92.639 * _xScaling,
      -84.3441 * _yScaling,
      105.34 * _xScaling,
      -67.3893 * _yScaling,
      115.685 * _xScaling,
      -50.8395 * _yScaling,
    );
    path.cubicTo(
      127.842 * _xScaling,
      -31.3905 * _yScaling,
      143.917 * _xScaling,
      -8.39552 * _yScaling,
      139.373 * _xScaling,
      10.9007 * _yScaling,
    );
    path.cubicTo(
      134.872 * _xScaling,
      30.0139 * _yScaling,
      113.053 * _xScaling,
      30.196 * _yScaling,
      96.0188 * _xScaling,
      32.6717 * _yScaling,
    );
    path.cubicTo(
      83.7405 * _xScaling,
      34.4561 * _yScaling,
      71.301 * _xScaling,
      26.5936 * _yScaling,
      58.1897 * _xScaling,
      22.6993 * _yScaling,
    );
    path.cubicTo(
      39.5397 * _xScaling,
      17.1599 * _yScaling,
      15.7528 * _xScaling,
      25.8609 * _yScaling,
      4.38817 * _xScaling,
      5.45547 * _yScaling,
    );
    path.cubicTo(
      4.38817 * _xScaling,
      5.45547 * _yScaling,
      4.38817 * _xScaling,
      5.45547 * _yScaling,
      4.38817 * _xScaling,
      5.45547 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
