import 'package:flutter/material.dart';
import 'package:red_crescent/Widget/AppBarMain.dart';

class Request extends StatefulWidget {
  const Request();

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: "تتبع الطلب"),
      body: Center(child: Text('request')),
    );
  }
}
