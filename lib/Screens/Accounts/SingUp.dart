import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:red_crescent/BackEnd/Database/DatabaseMethods.dart';
import 'package:red_crescent/Widget/AppLoading.dart';
import '../../Widget/AppConstants.dart';
import '../../Widget/AppWidget.dart';
import '../../Widget/AppRoutes.dart';
import '../../Widget/AppValidator.dart';
import '../../Widget/AppSize.dart';
import '../../Widget/AppButtons.dart';
import '../../Widget/AppText.dart';
import '../../Widget/AppTextFields.dart';
import '../../Widget/AppColors.dart';
import '../../Widget/AppDropList.dart';
import '../../Widget/AppImagePath.dart';
import 'Login.dart';
import 'package:provider/provider.dart';

class SingUp extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();

  GlobalKey<FormState> singUpKey = GlobalKey();
  String? selectedMajor;
  String? selectedSearch;
  SingUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: ShowColor.black,
     );
  }
}
