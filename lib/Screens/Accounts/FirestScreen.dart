import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppSvg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widget/AppRoutes.dart';
import 'SingUp.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),() {
      AppRoutes.pushReplacementTo(context,  SingUp());
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SvgPicture.asset(
            AppSvg.logoEn,
            height: 131.h,
            width: 125.w,
          ),
        ),
      ),
    );
  }
}
