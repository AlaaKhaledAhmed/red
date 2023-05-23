import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_crescent/Screens/Accounts/Login.dart';
import 'package:red_crescent/Screens/Accounts/SingUp.dart';
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
import '../../Database/DatabaseMethods.dart';
import '../../Widget/AppLoading.dart';
import '../../Widget/AppSvg.dart';
import '../Pataion/PationNav.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> addKey = GlobalKey();

  bool isShow = true;

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
                            text: 'تسجيل الدخول',
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
                                    obscureText: isShow,
                                    sufficIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isShow = !isShow;
                                          });
                                        },
                                        icon: Icon(Icons.visibility)),
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
                          text: 'تسجيل الدخول',
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (addKey.currentState?.validate() == true) {
                              AppLoading.show(context, '', 'lode');
                              Database.logging(
                                email: emailController.text,
                                password: passwordController.text,
                              ).then((String v) {
                                if (v == 'error') {
                                  Navigator.pop(context);
                                  AppLoading.show(
                                      context, 'تسجيل الدخول', 'حدث خطا ما');
                                } else if (v == 'user-not-found') {
                                  Navigator.pop(context);
                                  AppLoading.show(context, 'تسجيل الدخول',
                                      'البريد الالكتروني خطا');
                                } else if (v == 'wrong-password') {
                                  Navigator.pop(context);
                                  AppLoading.show(context, 'تسجيل الدخول',
                                      'كلمة المرور خطا');
                                } else {
                                  print('respoms is: $v');
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .where('userId', isEqualTo: v)
                                      .get()
                                      .then((value) {
                                    Navigator.pop(context);
                                    value.docs.forEach((element) {
                                      print('respoms is: $v');
                                      if (element.data()['type'] == 'pation') {

                                        AppRoutes.pushReplacementTo(context, const PationNav());
                                      } else if (element.data()['type'] ==
                                          'hospital') {
                                            AppRoutes.pushReplacementTo(context, const PationNav());
                                      
                                      } else {
                                        //nav
                                      }
                                    });
                                  });
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
                                AppRoutes.pushReplacementTo(context, SingUp()),
                            child: AppText(
                              text: 'ليس لديك حساب؟ انشاء حساب',
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
