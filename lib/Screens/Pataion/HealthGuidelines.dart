import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';

class HealthGuidelines extends StatefulWidget {
  const HealthGuidelines();

  @override
  State<HealthGuidelines> createState() => _HealthGuidelinesState();
}

class _HealthGuidelinesState extends State<HealthGuidelines> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBarMain(title: "مركز المساعدة"),
      body: Center(child: Text('helth')),
    );
  }
}