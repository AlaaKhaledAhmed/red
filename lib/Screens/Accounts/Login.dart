import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppClipperBlueContiner.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppGreenContainer.dart';
import 'package:red_crescent/Widget/AppSize.dart';
import 'package:red_crescent/Widget/AppText.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_crescent/Widget/AppClipperDarkBlueContainer.dart';
import '../../Widget/AppSvg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: AppWidget.getWidth(context),
            height: AppWidget.getHeight(context),
            child: Stack(
              children: [
//blue dark image============================================================================
                Positioned(
                  child: ClipPath(
                    clipper: AppClipperDarkBlueContainer(),
                    child: Container(
                      color: AppColor.darkBlue,
                    ),
                  ),
                ),
//blue image============================================================================
                Positioned(
                    child: Align(
                  alignment: const Alignment(1, 10),
                  child: ClipPath(
                    clipper: AppClipperBlueContainer(),
                    child: Container(
                      width: AppWidget.getWidth(context) * 0.90,
                      color: AppColor.blue,
                    ),
                  ),
                )),
//green image============================================================================
                Positioned(
                    child: Align(
                  alignment: const Alignment(10, 0),
                  child: ClipPath(
                    clipper: AppClipperGreenContainer(),
                    child: Container(
                      color: AppColor.green,
                      width: AppWidget.getWidth(context) * 0.90,
                    ),
                  ),
                )),
//logo image============================================================================
                Positioned(
                  top: 97.h,
                  left: 128.w,
                  right: 128.w,
                  child: SvgPicture.asset(
                    AppSvg.logoAr,
                    height: 50.h,
                    width: 99.w,
                  ),
                ),
//lodging text============================================================================
                Positioned(
                 top: 167.h,
                 right: 32.w,
                 left: 172.w,
                 child: AppText(
                  text: 'تسجيل الدخول',
                  fontSize: AppSize.titleTextSize+2,
                   fontWeight: FontWeight.bold,
                )),
//lodging text============================================================================
                Positioned(
                    top: 230.h,
                    right: 28.w,
                    left: 250.w,
                    child: AppText(
                      text: 'اسم المستخدم',
                      fontSize: AppSize.subTextSize,
                      fontWeight: FontWeight.bold,
                    )),
//textField text============================================================================
                Container()
              ],
            )),
      ),
    );
  }
}
