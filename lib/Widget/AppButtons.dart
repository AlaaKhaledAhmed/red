import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'package:red_crescent/Widget/AppText.dart';
import'package:red_crescent/Widget/AppColors.dart';
import'package:red_crescent/Widget/AppSize.dart';

class AppButtons extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? bagColor;
  final Color? textStyleColor;
  final TextOverflow? overflow;
  final double? width;
  final double? elevation;
  const AppButtons(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.bagColor,
      this.overflow,
      this.textStyleColor,
      this.width,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50.h,
      child: ElevatedButton(
        child: AppText(
          fontSize: AppSize.buttonsFontSize,
          text: text,
          color: textStyleColor ?? AppColor.buttonsTextColor,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        style: ElevatedButton.styleFrom(
          primary: bagColor ?? AppColor.buttonsColor,
          elevation: elevation ?? 1.5,
          textStyle: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              color: textStyleColor ?? AppColor.buttonsTextColor,
              fontSize: AppSize.buttonsFontSize,
              fontStyle: FontStyle.normal),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
