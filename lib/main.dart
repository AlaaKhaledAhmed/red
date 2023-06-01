import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:red_crescent/Screens/Accounts/Login.dart';
import 'package:red_crescent/Screens/Hospital/HospitalNav.dart';
import 'package:red_crescent/Screens/Pataion/PationNav.dart';
import 'package:red_crescent/Screens/RedCrescent/RedNav.dart';
import 'Screens/Accounts/FirestScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_crescent/Widget/AppColors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: GoogleFonts.inter().fontFamily,
            //"DroidKufi",
            scaffoldBackgroundColor: AppColor.white,
          ),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          home: HospitalNav(),
        );
      },
    );
  }
}
