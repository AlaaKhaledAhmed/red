import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppClipperBlueContiner.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppGreenContainer.dart';
import 'package:red_crescent/Widget/AppSize.dart';
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
                      color: ShowColor.darkBlue,
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
                      color: ShowColor.blue,
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
                      color: ShowColor.green,
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
//logo image============================================================================

              ],
            )),
      ),
    );
  }
}
