import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppButtons.dart';
import 'package:red_crescent/Widget/AppText.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppSize.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppLoading {
  static show(context, String title, String content,
      {bool showButtom = false,
      void Function()? yesFunction,
      void Function()? noFunction,
      double? higth}) {
    return showDialog(
        //barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            titlePadding: EdgeInsets.zero,
            elevation: 0,

            backgroundColor:
                content == "lode" ? Colors.transparent : AppColor.white,

//tittle-------------------------------------------------------------------

            title: content != "lode"
                ? Container(
                    decoration: BoxDecoration(
                        color: AppColor.darkBlue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                    width: double.infinity,
                    height: 40.h,
                    child: Center(
                      child: AppText(
                        fontSize: AppSize.buttonsFontSize,
                        text: title,
                        color: AppColor.white,
                      ),
                    ),
                  )
                : const SizedBox(),
//continent area-------------------------------------------------------------------

            content: content != "lode"
                ? SizedBox(
                    height: higth ?? 70.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
//continent tittle-------------------------------------------------------------------
                        Expanded(
                          flex: 3,
                          child: AppText(
                            fontSize: AppSize.subTextSize + 2,
                            text: content,
                            color: AppColor.black,
                            align: TextAlign.center,
                          ),
                        ),

//divider-------------------------------------------------------------------

                        showButtom
                            ?  Divider(
                                thickness: 1,
                                color: AppColor.textFieldBorderColor,
                              )
                            : const SizedBox(),
                        SizedBox(height: 10.h),
//bottoms-------------------------------------------------------------------

                        showButtom
                            ? Expanded(
                                flex: 2,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
// yes bottoms-------------------------------------------------------------------
                                      Expanded(
                                          child: AppButtons(
                                        onPressed: yesFunction,
                                        text: 'نعم',
                                        bagColor: AppColor.darkBlue,
                                      )),

                                      SizedBox(width: 20.w),
//no buttom-------------------------------------------------------------------
                                      Expanded(
                                        child: AppButtons(
                                          onPressed: noFunction,
                                          text: 'لا',
                                          bagColor: AppColor.darkBlue,
                                        ),
                                      )
                                    ]),
                              )
                            : const SizedBox(),
                      ],
                    ))
//Show Waiting image-------------------------------------------------------
                : SizedBox(
                    width: double.infinity,
                    height: 200.h,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator(
                        //"assets/Lottie/lode.json",
                        //fit: BoxFit.contain,
                      ),
                    ),
                  ),

//Show bottoms -------------------------------------------------------

            actions: [
              showButtom == false && content != "lode"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.exit_to_app,
                                color: AppColor.black, size: 35.sp)),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        });
  }
}
