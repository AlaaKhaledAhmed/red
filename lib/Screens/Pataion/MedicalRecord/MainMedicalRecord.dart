import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import 'package:red_crescent/Widget/AppRoutes.dart';
import '../../../../Widget/AppBarMain.dart';
import '../../../../Widget/AppButtons.dart';
import '../../../../Widget/AppConstants.dart';
import '../../../../Widget/AppDropList.dart';
import '../../../../Widget/AppLoading.dart';
import '../../../../Widget/AppSize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../Widget/AppTextFields.dart';
import '../../../../Widget/AppValidator.dart';
import '../../../../Widget/AppWidget.dart';
import '../../../Database/DatabaseMethods.dart';
import '../../../Widget/AppSvg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Widget/AppText.dart';
import 'AddMedicalRecord.dart';

class MainMedicalRecord extends StatefulWidget {
  const MainMedicalRecord();

  @override
  State<MainMedicalRecord> createState() => _MainMedicalRecordState();
}

class _MainMedicalRecordState extends State<MainMedicalRecord> {
  String? userId;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMain(
          title: "السجل الطبي",
          leading: IconButton(
              onPressed: () => AppRoutes.pushTo(context, AddMedicalRecord()),
              icon: Icon(
                Icons.add_chart,
                size: 35.sp,
              )),
        ),
        body: AppWidget.body(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
              ),
              child:
//body=====================================================
                  SizedBox(
                height: 150.h,
                child: StreamBuilder(
                    stream: AppConstants.medicalRecordCollection
                        .where('userId', isEqualTo: userId!)
                        .orderBy('createdOn', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Error check internet!"));
                      }
                      if (snapshot.hasData) {
                        return body(snapshot);
                      }

                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColor.appBarColor,
                      ));
                    }),
              )),
        ));
  }

//show data from database========================================================================
  Widget body(snapshot) {
    return snapshot.data.docs.isNotEmpty
        ? Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context2, i) {
                  var data = snapshot.data.docs[i].data();
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: SizedBox(
                      height: 220.h,
                      width: AppWidget.getWidth(context2),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          //set border radius more than 50% of height and width to make circle
                        ),
//user status=================================================================
                        child: Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: AppText(
                                  text: 'اسم المرض: ${data['disease']}',
                                  fontSize: AppSize.title2TextSize,
                                ),
                              ),
//status=================================================================

                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: 'الحساسة: ${data['sensitive']}',
                                    fontSize: AppSize.subTextSize + 2,
                                  ),

                                  ///phone and call
                                  AppText(
                                    text: 'فصيلة الدم: ${data['bloodType']}',
                                    fontSize: AppSize.subTextSize + 2,
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    AppLoading.show(
                                        context2,
                                        AppMessage.deleteData,
                                        AppMessage.confirmDelete,
                                        showButtom: true,
                                        noFunction: () {
                                          Navigator.pop(context2);
                                        },
                                        higth: 100.h,
                                        yesFunction: () async {
                                          Navigator.pop(context2);
                                          await Database.delete(
                                            collection: 'medicalRecord',
                                            docId: snapshot.data.docs[i].id,
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: AppSize.iconSize,
                                    color: AppColor.green,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration:
                                  AppWidget.decoration(color: AppColor.green),
                              width: double.infinity,
                              child: IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: AppSize.iconSize,
                                    color: AppColor.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child: AppText(
                text: AppMessage.noData,
                fontSize: AppSize.titleTextSize,
                fontWeight: FontWeight.bold),
          );
  }
}
