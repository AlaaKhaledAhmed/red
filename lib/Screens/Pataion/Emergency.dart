import 'package:flutter/material.dart';
import 'package:red_crescent/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';
import 'package:red_crescent/Widget/AppButtons.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppLoading.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import 'package:red_crescent/Widget/AppSize.dart';
import 'package:red_crescent/Widget/AppText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

class Emergency extends StatefulWidget {
  const Emergency();

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  String? userId;

  LocationData? currentLocation;
  int? tab;
  String? phone;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
    Future.delayed(
      Duration.zero,
      () async {
        currentLocation = await Database.getCurrentLocation();
        await getPhone();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(title: "الطوارئ"),
      body: SizedBox(
        height: AppWidget.getHeight(context),
        width: AppWidget.getWidth(context),
        child: Column(children: [
          AppWidget.hSpace(30),
          AppText(
            text: "اختر حالة الطوارئ",
            fontSize: AppSize.title2TextSize,
            fontFamily: GoogleFonts.notoKufiArabic().fontFamily,
            align: TextAlign.left,
          ),
          AppWidget.hSpace(30),

          /// list
          Expanded(child: showEmergencyList()),
          AppWidget.hSpace(20),

          ///send buttom
          tab == null
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: AppButtons(
                    text: "ارسال",
                    onPressed: () async {
                      print('currentLocation)' + currentLocation.toString());
                      AppLoading.show(context, 'lode', 'lode');
                      if (currentLocation.toString() == "locationNotEnable") {
                        Navigator.pop(context);
                        AppLoading.show(context, AppMessage.addData,
                            AppMessage.locationNotEnable);
                      } else if (currentLocation.toString() ==
                          'PERMISSION_DENIED') {
                        Navigator.pop(context);
                        AppLoading.show(
                            context, AppMessage.addData, AppMessage.denied);
                      } else {
                        Database.sendRequest(
                          userId: userId!,
                          userStatus: AppConstants.list[tab!],
                          lang: currentLocation!.longitude!,
                          lat: currentLocation!.latitude!,
                          requestFrom: AppConstants.requestFromPatient,
                          hospitalId: '',
                          medicalRecordFile: '',
                          phone: phone!,
                        ).then((v) {
                          print('================$v');
                          if (v == 'done') {
                            setState(() {
                              tab = null;
                            });
                            Navigator.pop(context);
                            AppLoading.show(context, AppMessage.addData,
                                AppMessage.doneData);
                          } else {
                            Navigator.pop(context);
                            AppLoading.show(
                                context, AppMessage.addData, AppMessage.erroe);
                          }
                        });
                      }
                    },
                    bagColor: AppColor.blue,
                    textStyleColor: AppColor.white,
                    width: 120.w,
                  ),
                )
        ]),
      ),
    );
  }

//======================================================
  Widget showEmergencyList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //عدد العناصر في كل صف
            crossAxisSpacing: 10, // المسافات الراسية
            childAspectRatio: 1.90, //حجم العناصر
            mainAxisSpacing: 10 //المسافات الافقية

            ),
        itemCount: AppConstants.list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButtons(
              text: AppConstants.list[index],
              onPressed: () {
                setState(() {
                  tab = index;
                });
              },
              bagColor: tab == index ? AppColor.darkBlue : AppColor.white,
              textStyleColor: tab == index ? AppColor.white : AppColor.black,
              width: 120.w,
            ),
          );
        });
  }

//================================================================
  Future<void> getPhone() async {
    await AppConstants.userCollection
        .where("userId", isEqualTo: userId!)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (mounted) {
          setState(() {
            phone = element["phone"];
          });
        }
      });
    });
  }
}
