import 'package:flutter/material.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppWidget {
  final BuildContext context;

  const AppWidget({required this.context});
  //==========================================================
  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  //==========================================================
  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  //==========================================================
  static Widget hSpace(double space) {
    return SizedBox(height: space.h);
  }

  //==========================================================
  static Widget wSpace(space) {
    return SizedBox(
      width: space,
    );
  }

//scroll body===========================================================
  static body({required Widget? child}) {
    return LayoutBuilder(builder: ((context, constraints) {
      return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification? overscroll) {
            overscroll!.disallowGlow();
            return true;
          },
          child: SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: child),
          )));
      // AppText(text: LocaleKeys.myTeam.tr(), fontSize: WidgetSize.titleTextSize);
    }));
  }


  //container decoration===============================================================
  static BoxDecoration decoration({double? radius, Color? color}) {
    return BoxDecoration(
        color: color ?? AppColor.white,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 20.r)));
  }

  //unique number========================================================================
  static int uniqueOrder() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  //==========================================================
  static String? getUid()  {
    String? uid=FirebaseAuth.instance.currentUser?.uid;
    return uid;
  }
}
