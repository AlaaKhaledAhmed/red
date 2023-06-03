import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:red_crescent/Screens/Pataion/MedicalRecord/showMedicalRecord.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import 'package:red_crescent/Widget/AppRoutes.dart';
import '../../../../Widget/AppBarMain.dart';
import 'dart:typed_data';
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
import 'UpdateMedicalRecord.dart';

class MainMedicalRecord extends StatefulWidget {
  final String userIdFromRed;
  final bool fromRed;
  final bool showReport;

  final bool showReportSectionInPdf;
  const MainMedicalRecord(
      {required this.userIdFromRed,
      required this.fromRed,
      required this.showReportSectionInPdf,
      required this.showReport});

  @override
  State<MainMedicalRecord> createState() => _MainMedicalRecordState();
}

class _MainMedicalRecordState extends State<MainMedicalRecord> {
  String? userId;
  String bloodType = '';
  Uint8List? bytes;
  List diseaseList = [];
  List sensitiveList = [];
  List<String> reportsList = [];
  @override
  void initState() {
    super.initState();
    userId = widget.userIdFromRed.isEmpty
        ? FirebaseAuth.instance.currentUser!.uid
        : widget.userIdFromRed;
  }

  @override
  Widget build(BuildContext context) {
    print('reportsList in mainMedical: $reportsList');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarMain(
            title: "السجل الطبي",
            leading: IconButton(
                onPressed: () => AppRoutes.pushTo(
                    context,
                    AddMedicalRecord(
                      showReport: widget.showReport,
                      userIdFromRed: widget.userIdFromRed,
                    )),
                icon: Icon(
                  Icons.add_chart,
                  size: 35.sp,
                )),
            action: [
              IconButton(
                  onPressed: () async {
                    AppLoading.show(context, 'lode', 'lode');
                    GenerateFile.openPdf(await GenerateFile.getDocumentPdf(
                        bytes: await showFile()));
                        Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.picture_as_pdf,
                    size: 35.sp,
                  ))
            ],
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
          )),
    );
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

                                  ///
                                  AppText(
                                    text: 'فصيلة الدم: ${data['bloodType']}',
                                    fontSize: AppSize.subTextSize + 2,
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: widget.fromRed == true
                                      ? null
                                      : () async {
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
                                                  docId:
                                                      snapshot.data.docs[i].id,
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
                                  onPressed: widget.fromRed == true
                                      ? null
                                      : () async {
                                          AppRoutes.pushTo(
                                              context,
                                              UpdateMedicalRecord(
                                                bloodTypeController:
                                                    data['bloodType'],
                                                docId: snapshot.data.docs[i].id,
                                                diseaseController:
                                                    data['disease'],
                                                sensitiveController:
                                                    data['sensitive'],
                                                hospitalId: data['hospitalId'],
                                              ));
                                        },
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

  //======================================
  Future showFile() async {
    await getData();
    await getReports();
    bytes = await GenerateFile.generatePdf(
        showReport: widget.showReportSectionInPdf,
        reportsList: reportsList,
        bloodType: bloodType,
        sensitiveList: sensitiveList,
        pId: '',
        diseaseList: diseaseList);
    return bytes;
  }

  //================================
  Future<void> getData() async {
    await AppConstants.medicalRecordCollection
        .where("userId", isEqualTo: userId!)
        .get()
        .then((value) {
      diseaseList.clear();
      sensitiveList.clear();
      value.docs.forEach((element) {
        setState(() {
          diseaseList.add(element["disease"]);
          sensitiveList.add(element["sensitive"]);
          bloodType = element['bloodType'];
        });
      });
    });
  }

//================================
  Future<void> getReports() async {
    await AppConstants.reportCollection
        .where("userId", isEqualTo: userId!)
        .get()
        .then((value) {
      reportsList.clear();
      value.docs.forEach((element) {
        setState(() {
          reportsList.add(element["reportText"]);
        });
      });
    });
  }
}
