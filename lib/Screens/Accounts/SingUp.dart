import 'dart:math';

import 'package:flutter/material.dart';
import 'package:red_crescent/Screens/Accounts/Login.dart';
import 'package:red_crescent/Widget/AppButtons.dart';
import 'package:red_crescent/Widget/AppClipperBlueContiner.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppGreenContainer.dart';
import 'package:red_crescent/Widget/AppRoutes.dart';
import 'package:red_crescent/Widget/AppSize.dart';
import 'package:red_crescent/Widget/AppText.dart';
import 'package:red_crescent/Widget/AppTextFields.dart';
import 'package:red_crescent/Widget/AppValidator.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_crescent/Widget/AppClipperDarkBlueContainer.dart';
import '../../BackEnd/Database/DatabaseMethods.dart';
import '../../Widget/AppLoading.dart';
import '../../Widget/AppSvg.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    bottom = max(min(bottom, 80), 0);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                      maxHeight: viewportConstraints.maxHeight),
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
                          child: AppText(
                            text: 'إنشاء حساب',
                            fontSize: AppSize.titleTextSize + 2,
                            fontWeight: FontWeight.bold,
                          )),

//textField============================================================================
                      Positioned(
                        top: 230.h,
                        right: 28.w,
                        left: 28.w,
                        bottom: 200.h,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 400.w,
                            width: AppWidget.getWidth(context),
                            // color: Colors.red,
                            child: Form(
                              key: addKey,
                              child: ListView(
                                children: [
                                  ///name=======================================
                                  AppTextFields(
                                    controller: nameController,
                                    labelText: 'الاسم',
                                    validator: (v) =>
                                        AppValidator.validatorName(v),
                                  ),
                                  AppWidget.hSpace(AppSize.hSpace),

                                  ///email=======================================
                                  AppTextFields(
                                    controller: emailController,
                                    labelText: 'البريد الالكتروني',
                                    validator: (v) =>
                                        AppValidator.validatorEmail(v),
                                  ),
                                  AppWidget.hSpace(AppSize.hSpace),

                                  ///pass=======================================
                                  AppTextFields(
                                    controller: passwordController,
                                    labelText: 'كلمة المرور',
                                    validator: (v) =>
                                        AppValidator.validatorPassword(v),
                                  ),
                                  AppWidget.hSpace(AppSize.hSpace),

                                  ///phone=======================================
                                  AppTextFields(
                                    controller: phoneController,
                                    labelText: 'رقم الجوال',
                                    validator: (v) =>
                                        AppValidator.validatorPhone(v),
                                  ),
                                  AppWidget.hSpace(AppSize.hSpace),

                                  ///address=======================================
                                  AppTextFields(
                                    controller: addressController,
                                    labelText: 'العنوان',
                                    validator: (v) =>
                                        AppValidator.validatorEmpty(v),
                                  ),
                                  AppWidget.hSpace(AppSize.hSpace),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
//sing up buttom============================================================================
                      Positioned(
                        top: 600.h,
                        left: 28.w,
                        right: 28.w,
                        child: AppButtons(
                          text: 'انشاء حساب',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (addKey.currentState?.validate() == true) {
                              AppLoading.show(context, '', 'lode');
                              Database.singUp(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                address: addressController.text,
                                phone: phoneController.text,
                              ).then((String v) {
                                print('================$v');
                                if (v == 'done') {
                                  Navigator.pop(context);
                                  AppLoading.show(context, 'انشاء حساب',
                                      'تمت العملية بنجاح');
                                } else if (v == 'weak-password') {
                                  Navigator.pop(context);
                                  AppLoading.show(context, 'انشاء حساب',
                                      'كلمة المرور ضعيفة');
                                } else if (v == 'email-already-in-use') {
                                  Navigator.pop(context);
                                  AppLoading.show(context, 'انشاء حساب',
                                      'البريد الالكتروني موجود مسبقا');
                                } else {
                                  Navigator.pop(context);
                                  AppLoading.show(
                                      context, 'انشاء حساب', 'حدث خطا ما');
                                }
                              });
                            }
                          },
                          width: 270.w,
                          bagColor: AppColor.darkBlue,
                        ),
                      ),
//no hav account text============================================================================
                      Positioned(
                          top: 670.h,
                          right: 90.w,
                          left: 90.w,
                          child: InkWell(
                            onTap: () =>
                                AppRoutes.pushReplacementTo(context, Login()),
                            child: AppText(
                              text: 'لديك حساب؟ تسجيل الدخول',
                              fontSize: AppSize.subTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
