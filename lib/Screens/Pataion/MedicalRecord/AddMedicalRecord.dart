import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import '../../../../Widget/AppBarMain.dart';
import '../../../../Widget/AppButtons.dart';
import '../../../../Widget/AppLoading.dart';
import '../../../../Widget/AppSize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../Widget/AppTextFields.dart';
import '../../../../Widget/AppValidator.dart';
import '../../../../Widget/AppWidget.dart';
import '../../../Database/DatabaseMethods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Widget/AppText.dart';

class AddMedicalRecord extends StatefulWidget {
  final String userIdFromRed;
  const AddMedicalRecord({Key? key, required this.userIdFromRed})
      : super(key: key);

  @override
  State<AddMedicalRecord> createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  TextEditingController diseaseController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController sensitiveController = TextEditingController();
  GlobalKey<FormState> updateKey = GlobalKey<FormState>();

  String? userId;
  String? docId;
  int? foundRecord;
  @override
  void initState() {
    super.initState();
    userId = widget.userIdFromRed.isEmpty
        ? FirebaseAuth.instance.currentUser!.uid
        : widget.userIdFromRed;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: const AppBarMain(
            title: 'السجل الطبي',
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
                  //show medical record======================================================
                  InkWell(
                    onTap: null, // () => showMidicalRecord(),
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColor.grey100,
                      child: Icon(Icons.receipt_long_sharp, size: 50.r),
                    ),
                  ),
                  AppWidget.hSpace(30.h),
                  AppText(
                    fontSize: AppSize.title2TextSize,
                    text:
                        'من فضلك قم بتعبئة الحقول ادناه للاضافة على السجل الطبي',
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                  ),
                  AppWidget.hSpace(20.h),

                  ///disease=======================================
                  AppTextFields(
                    controller: diseaseController,
                    labelText: 'اضافة مرض مزمن',
                    validator: (v) => AppValidator.validatorEmpty(v),
                  ),
                  AppWidget.hSpace(AppSize.hSpace),

                  ///sensitive=======================================
                  AppTextFields(
                    controller: sensitiveController,
                    labelText: 'اضافة حساسية',
                    validator: (v) => AppValidator.validatorEmpty(v),
                  ),
                  AppWidget.hSpace(AppSize.hSpace),

                  ///bloodType=======================================
                  AppTextFields(
                    controller: bloodTypeController,
                    labelText: 'فصيلة الدم',
                    validator: (v) => AppValidator.validatorEmpty(v),
                  ),
                  AppWidget.hSpace(20.h),
                  AppButtons(
                    text: 'اضافة للسجل الطبي',
                    onPressed: () {
                      if (updateKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        AppLoading.show(context, '', 'lode');
                        Database.addMedicalRecord(
                                bloodType: bloodTypeController.text,
                                disease: diseaseController.text,
                                hospitalId: '',
                                sensitive: sensitiveController.text,
                                userId: userId!)
                            .then((String v) {
                          print('================++$v');
                          if (v == 'done') {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            AppLoading.show(context, AppMessage.medicalRecord,
                                AppMessage.doneData);
                          } else {
                            Navigator.pop(context);
                            AppLoading.show(context, AppMessage.medicalRecord,
                                AppMessage.error);
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
}
