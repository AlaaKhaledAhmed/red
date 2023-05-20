import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:red_crescent/Widget/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppSize.dart';

class AppTextFields extends StatelessWidget {
  final bool? obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? labelText;
  final FontWeight? fontWeight;
  const AppTextFields({
    Key? key,
    required this.validator,
    this.inputFormatters,
    this.keyboardType,
    required this.controller,
    required this.labelText,
    this.fontWeight,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      style: TextStyle(
          color: AppColor.mainTextFieldsColor,
          fontSize: AppSize.textFieldsFontSize),
      decoration: InputDecoration(

          filled: true,
          hintStyle: TextStyle(
              color: AppColor.labelTextFieldsColor,
              fontSize: AppSize.textFieldsHintSize),
          fillColor: AppColor.white,
          labelStyle: TextStyle(
              color: AppColor.labelTextFieldsColor,
              fontSize: AppSize.textFieldsFontSize),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppSize.textFieldsBorderRadius),
            borderSide: BorderSide(
              color: Colors.blue,
              width: AppSize.textFieldsBorderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppSize.textFieldsBorderRadius),
            borderSide: BorderSide(
              color: AppColor.buttonsColor,
              width: AppSize.textFieldsBorderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppSize.textFieldsBorderRadius),
            borderSide: BorderSide(
              color: AppColor.textFieldBorderColor,
              width: AppSize.textFieldsBorderWidth,
            ),
          ),
          labelText: labelText,
          //errorStyle: TextStyle(color: AppColor.errorColor, fontSize: WidgetSize.errorSize),
          contentPadding: EdgeInsets.all(AppSize.contentPadding)),
    );
  }
}
