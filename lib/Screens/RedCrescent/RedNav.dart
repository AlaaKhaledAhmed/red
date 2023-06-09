import 'package:flutter/material.dart';
import 'package:red_crescent/Screens/Pataion/MedicalRecord/MainMedicalRecord.dart';
import 'package:red_crescent/Widget/AppDropList.dart';
import 'package:red_crescent/Widget/AppLoading.dart';
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
  List<String?> selectHospital = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];
  String? selectHospitalId;
  List<String> hospitalNameList = ['الملك فهد', 'احد', 'المدينة العام'];
  List<String> hospitalIdList = [
    'ZHc3fBUEOOaum5MtSOVLYYz2AY02',
    'tqqvMxnHefXWnrFfpcSW5ITh18o2',
    'qc6Dvyg0eRgnbZUYWPgj2HwJzZl2'
  ];
  int? tab;
  GlobalKey<FormState> addKey = GlobalKey();
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
            height: AppWidget.getHeight(context),
            width: AppWidget.getWidth(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: StreamBuilder(
                  stream: AppConstants.requestCollection
                      .where('to', isEqualTo: AppConstants.requestToRed)
                      .orderBy('createdOn', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text("Error check internet!"));
                    }
                    if (snapshot.hasData) {
                      return body(snapshot);
                    }

                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColor.appBarColor,
                    ));
                  }),
            ),
          ),
        ));
  }

//show data from database========================================================================
  Widget body(snapshot) {
    return snapshot.data.docs.isNotEmpty
        ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context2, i) {
              var data = snapshot.data.docs[i].data();
              return SizedBox(
                height: tab == i ? 310.h : 330.h,
                width: AppWidget.getWidth(context2),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
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
//Accept call menu==============================================================
                      SizedBox(
                        height: 10.h,
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
                              decoration: AppWidget.decoration(
                                  color: AppConstants.statusIsAcceptFromRed ==
                                          data['status']
                                      ? AppColor.grey600
                                      : AppColor.blue),
                              child: IconButton(
                                  onPressed: AppConstants.statusIsSend !=
                                          data['status']
                                      ? null
                                      : () async {
                                          setState(() {
                                            tab = i;
                                          });
                                          if (addKey.currentState?.validate() ==
                                                  true &&
                                              selectHospital[i] != null) {
                                            AppLoading.show(
                                                context2,
                                                AppMessage.accept,
                                                AppMessage.confirmAccept,
                                                showButtom: true,
                                                noFunction: () {
                                                  Navigator.pop(context2);
                                                },
                                                higth: 100.h,
                                                yesFunction: () async {
                                                  Navigator.pop(context2);
                                                  await Database.updateRequest(
                                                      hospitalName:
                                                          '${selectHospital[i]}',
                                                      docId: snapshot
                                                          .data.docs[i].id,
                                                      status: AppConstants
                                                          .statusIsAcceptFromRed,
                                                      hospitalId:
                                                          selectHospitalId!);
                                                });
                                          } else {
                                            AppLoading.show(
                                                context2,
                                                AppMessage.accept,
                                                AppMessage.selectHospital);
                                          }
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
                            flex: 2,
                            child: Form(
                              key: tab == i ? addKey : null,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0.w),
                                child: AppDropList(
                                  validator: (v) {
                                    if (v == null) {
                                      return AppMessage.empty;
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: AppConstants.statusIsSend !=
                                          data['status']
                                      ? null
                                      : (selectedItem) {
                                          setState(() {
                                            {
                                              selectHospital[i] = selectedItem!;
                                              selectHospitalId = hospitalIdList[
                                                  hospitalNameList
                                                      .indexOf(selectedItem)];

                                              print(
                                                  'selectHospital: ${selectHospital[i]}');
                                              print(
                                                  'selectHospitalId: $selectHospitalId');
                                            }
                                          });
                                        },
                                  listItem: hospitalNameList,
                                  hintText:
                                      AppConstants.statusIsAcceptFromRed ==
                                              data['status']
                                          ? data['hospitalName']
                                          : AppMessage.selectHospitalName,
                                  dropValue: selectHospital[i],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

//show pataient medical record=========================================================================
                      ,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 20.h),
                        decoration:
                            AppWidget.decoration(color: AppColor.darkBlue),
                        child: IconButton(
                            onPressed: () async {
                              AppRoutes.pushTo(
                                  context,
                                  MainMedicalRecord(
                                     showReportSectionInPdf: true,
                                    showReport: true,
                                    userIdFromRed: data['userId'],
                                    fromRed: true,
                                  ));
                            },
                            icon: AppText(
                              text: 'عرض السجل الطبي',
                              fontSize: AppSize.subTextSize,
                              color: AppColor.white,
                            )),
                      )
                    ],
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
