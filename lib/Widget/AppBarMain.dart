import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'package:red_crescent/Widget/AppText.dart';
import'package:red_crescent/Widget/AppColors.dart';
import'package:red_crescent/Widget/AppSize.dart';
class AppBarMain extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Color? background;
  final Color? textColor;
  final double? elevation;
  final double? radius;
  final double? high;
  const AppBarMain(
      {Key? key,
      required this.title,
      this.background,
      this.elevation,
      this.radius,
      this.high,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: elevation ?? 2,
      backgroundColor: background ?? AppColor.appBarColor,
      title: AppText(
        fontSize: AppSize.titleTextSize,
        text: title,
        color: textColor ?? AppColor.white,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius ?? 100.r),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(high ?? 85.r);
}
