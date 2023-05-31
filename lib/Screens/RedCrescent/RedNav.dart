import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:red_crescent/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppMessage.dart';
import 'package:red_crescent/Widget/AppSvg.dart';
import '../../Widget/AppColors.dart';
import '../../Widget/AppIcons.dart';
import '../../Widget/AppSize.dart';
import '../../Widget/AppText.dart';
import '../../Widget/AppWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RedNav extends StatefulWidget {
  const RedNav({Key? key}) : super(key: key);

  @override
  State<RedNav> createState() => _RedNavState();
}

class _RedNavState extends State<RedNav> {
  String? userId;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarMain(
          title: "طلبات الطوارئ",
        ),
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
                            .where('userId', isEqualTo: userId!)
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
        ));
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
                  height: 130.h,
                  width: AppWidget.getWidth(context),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      //set border radius more than 50% of height and width to make circle
                    ),
//user status=================================================================
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: AppText(
                          text: 'حالة الطوارئ : ${data['userStatus']}',
                          fontSize: AppSize.title2TextSize,
                        ),
                      ),
//status=================================================================
                      subtitle: AppText(
                        text:
                            'حالة الطلب: ${AppWidget.getStutus(data['status'])}',
                        fontSize: AppSize.subTextSize + 2,
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            Database.showUserLocation(
                                latitude: data['lat'], longitude: data['lang']);
                          },
                          icon: Icon(
                            Icons.location_on_sharp,
                            size: AppSize.iconSize,
                            color: AppColor.green,
                          )),
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
