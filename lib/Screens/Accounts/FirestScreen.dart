import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:red_crescent/BackEnd/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppButtons.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:red_crescent/Widget/AppSvg.dart';

import '../../Widget/AppRoutes.dart';
import 'Login.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ShowButtons(
            width: 20,
            onPressed: () {
              AddToFirebase.singUp(
                      name: 'name',
                      email: 'tat@gmail.com',
                      password: 'password',
                      address: 'address',
                      phone: 'phone')
                  .then((value) {
                print(value);
              });
            },
            text: "انشاء حساب"),
      ),
    );
  }
}
