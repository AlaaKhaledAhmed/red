
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import '../../../Widget/AppBarMain.dart';
import '../../../Widget/AppButtons.dart';
import '../../../Widget/AppConstants.dart';
import '../../../Widget/AppLoading.dart';
import '../../../Widget/AppSize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Widget/AppTextFields.dart';
import '../../../Widget/AppValidator.dart';
import '../../../Widget/AppWidget.dart';
import '../../Database/DatabaseMethods.dart';
import '../../Widget/AppSvg.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> updateKey = GlobalKey<FormState>();

  String? userId;
  String? selectedMajor;
  String? selectedSearch;
  String? docId;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.rtl ,
      child: Scaffold(
          appBar: const AppBarMain(
            title: 'تعديل المعلومات',
          ),
          body: AppWidget.body(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Form(
              key: updateKey,
              child: Column(
                children: [
                  AppWidget.hSpace(AppSize.hSpace),
                  AppWidget.hSpace(AppSize.hSpace),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundColor: AppColor.grey100,
                    child: SvgPicture.asset(
                      AppSvg.logoAr,
                      height: 50.h,
                      width: 99.w,
                    ),
                  ),
                  AppWidget.hSpace(30.h),

                  ///name=======================================
                  AppTextFields(
                    controller: nameController,
                    labelText: 'الاسم',
                    validator: (v) => AppValidator.validatorName(v),
                  ),
                  AppWidget.hSpace(AppSize.hSpace),

                  ///phone=======================================
                  AppTextFields(
                    controller: phoneController,
                    labelText: 'رقم الجوال',
                    validator: (v) => AppValidator.validatorPhone(v),
                  ),
                  AppWidget.hSpace(AppSize.hSpace),

                  ///address=======================================
                  AppTextFields(
                    controller: addressController,
                    labelText: 'العنوان',
                    validator: (v) => AppValidator.validatorEmpty(v),
                  ),
                  AppWidget.hSpace(20.h),
                  AppButtons(
                    text: 'تحديث المعلومات',
                    onPressed: () {
                      if (updateKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        AppLoading.show(context, '', 'lode');
                        Database.updateProfile(
                          name: nameController.text,
                          address: addressController.text,
                          phone: phoneController.text,
                          docId: docId!,
                        ).then((String v) {
                          print('================$v');
                          if (v == 'done') {
                            Navigator.pop(context);
                            AppLoading.show(context, AppMessage.updateData,
                                AppMessage.doneData);
                          } else {
                            Navigator.pop(context);
                            AppLoading.show(
                                context, AppMessage.updateData, AppMessage.erroe);
                          }
                        });
                      }
                    },
                    // width: 270.w,
                    bagColor: AppColor.darkBlue,
                  ),
                ],
              ),
            ),
          ))),
    );
  }

//========================================================================
  Future<void> getData() async {
    await AppConstants.userCollection
        .where("userId", isEqualTo: userId!)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          addressController =
              TextEditingController(text: "${element["address"]}");
          nameController = TextEditingController(text: "${element["name"]}");
          phoneController = TextEditingController(text: "${element["phone"]}");
          docId = element.id;
        });
      });
    });
  }
}
