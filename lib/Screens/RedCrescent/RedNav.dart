import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:red_crescent/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import '../../Widget/AppColors.dart';
import '../../Widget/AppRoutes.dart';
import '../../Widget/AppSize.dart';
import '../../Widget/AppText.dart';
import '../../Widget/AppWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Accounts/Login.dart';

class RedNav extends StatefulWidget {
  const RedNav({Key? key}) : super(key: key);

  @override
  State<RedNav> createState() => _RedNavState();
}

class _RedNavState extends State<RedNav> {
  String? selectHospital;
  String? selectHospitalId;
  List<String>? selectHospitalNameList = ['الملك فهد', 'احد', 'المدينة العام'];
  List<String>? selectHospitalIdList = [
    'ZHc3fBUEOOaum5MtSOVLYYz2AY02',
    'tqqvMxnHefXWnrFfpcSW5ITh18o2',
    'qc6Dvyg0eRgnbZUYWPgj2HwJzZl2'
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarMain(title: "طلبات الهلال الاحمر", action: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  AppRoutes.pushReplacementTo(context, Login());
                },
                icon: const Icon(Icons.logout_rounded)),
          ]),
          body: SizedBox(
            // color: Colors.green,
            height: AppWidget.getHeight(context),
            width: AppWidget.getWidth(context),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
//body=====================================================
                    Container(
                      height: AppWidget.getHeight(context),
                      decoration: AppWidget.decoration(radius: 10.r),
                      width: AppWidget.getWidth(context),
                      child: StreamBuilder(
                          stream: AppConstants.requestCollection
                              .where('to', isEqualTo: AppConstants.requestToRed)
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
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

//show data from database========================================================================
  Widget body(snapshot) {
    return snapshot.data.docs.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, i) {
              var data = snapshot.data.docs[i].data();
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: SizedBox(
                  height: 220.h,
                  width: AppWidget.getWidth(context),
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
                              text: 'حالة الطوارئ : ${data['userStatus']}',
                              fontSize: AppSize.title2TextSize,
                            ),
                          ),
//status=================================================================

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text:
                                    'حالة الطلب: ${AppWidget.getStutus(data['status'])}',
                                fontSize: AppSize.subTextSize + 2,
                              ),

                              ///phone and call
                              AppText(
                                text: 'رقم الاتصال: ${data['phone']}',
                                fontSize: AppSize.subTextSize + 2,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () async {
                                Database.showUserLocation(
                                    latitude: data['lat'],
                                    longitude: data['lang']);
                              },
                              icon: Icon(
                                Icons.location_on_sharp,
                                size: AppSize.iconSize,
                                color: AppColor.green,
                              )),
                        ),
                        Row(
                          children: [
//call==========================================================================================
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: AppWidget.decoration(
                                    color: AppColor.darkBlue),
                                child: IconButton(
                                    onPressed: () async {
                                      String url = 'tel:' + data['phone'];
                                      await launch(url);
                                    },
                                    icon: Icon(
                                      Icons.phone,
                                      size: AppSize.iconSize,
                                      color: AppColor.white,
                                    )),
                              ),
                            ),
//accept==========================================================================================

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration:
                                    AppWidget.decoration(color: AppColor.blue),
                                child: IconButton(
                                    onPressed: () async {
                                      String url = 'tel:' + data['phone'];
                                      await launch(url);
                                    },
                                    icon: Icon(
                                      Icons.check_circle_outlined,
                                      size: AppSize.iconSize,
                                      color: AppColor.white,
                                    )),
                              ),
                            ),
//select hospital==========================================================================================
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration:
                                    AppWidget.decoration(color: AppColor.green),
                                child: IconButton(
                                    onPressed: () async {
                                      String url = 'tel:' + data['phone'];
                                      await launch(url);
                                    },
                                    icon: Icon(
                                      Icons.check_circle_outlined,
                                      size: AppSize.iconSize,
                                      color: AppColor.white,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Center(
            child: AppText(
                text: AppMessage.noData,
                fontSize: AppSize.titleTextSize,
                fontWeight: FontWeight.bold),
          );
  }
}
