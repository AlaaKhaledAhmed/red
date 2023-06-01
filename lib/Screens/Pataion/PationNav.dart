import 'package:flutter/material.dart';
import 'package:red_crescent/Screens/Pataion/Emergency.dart';
import 'package:red_crescent/Screens/Pataion/Profile.dart';
import 'package:red_crescent/Widget/AppColors.dart';

import 'HealthGuidelines.dart';
import 'MedicalRecord/AddMedicalRecord.dart';
import 'MedicalRecord/MainMedicalRecord.dart';
import 'Request.dart';

class PatientNav extends StatefulWidget {
  const PatientNav();

  @override
  State<PatientNav> createState() => _PatientNavState();
}

class _PatientNavState extends State<PatientNav> {
  int selectedIndex = 2;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  List<Widget> page = [
    const Emergency(),
    const MainMedicalRecord(fromRed: false, userIdFromRed: ''),
    const Request(),
    const HealthGuidelines(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: page,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColor.darkBlue,
          selectedFontSize: 14,
          selectedItemColor: AppColor.white,
          unselectedItemColor: Colors.grey[400],
          unselectedFontSize: 11,
          currentIndex: selectedIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.emergency_rounded),
              label: "الطوارئ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monitor_heart),
              label: "السجل الطبي",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_from_queue_outlined),
              label: "تتبع الطلب",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_help),
              label: "مساعدة",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: "حسابي",
            ),
          ],
        ),
      ),
    );
  }

//
  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController?.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInCirc);
  }
}
