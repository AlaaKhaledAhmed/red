import 'package:flutter/material.dart';
import 'package:red_crescent/Screens/Pataion/Emergency.dart';
import 'package:red_crescent/Widget/AppColors.dart';

import 'HealthGuidelines.dart';
import 'Request.dart';

class PationNav extends StatefulWidget {
  const PationNav();

  @override
  State<PationNav> createState() => _PationNavState();
}

class _PationNavState extends State<PationNav> {
  int selectedIndex = 0;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  List<Widget> page = [
    const Request(),
    const Emergency(),
    const HealthGuidelines(),
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
              icon: Icon(Icons.remove_from_queue_outlined),
              label: "تتبع الطلب",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emergency_rounded),
              label: "الطوارئ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_help),
              label: "مساعدة",
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
