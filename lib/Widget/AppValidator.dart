import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';

import 'AppConstants.dart';

class AppValidator {
//valid empty data============================================================
  static String? validatorEmpty(v) {
    if (v.isEmpty || v==null) {
      return 'حقل اجباري';
    } else {
      return null;
    }
  }

//valid name data============================================================
  static String? validatorName(name) {
    final nameRegExp = RegExp(r"^\s*([A-Za-z]{2,10})$");
    if (name.isEmpty) {
      return 'حقل اجباري';
    }
    if (nameRegExp.hasMatch(name) == false) {
      return"رقم غير صالح";
    } else {
      return null;
    }
  }

  //valid email=============================================================
  static String? validatorEmail(email) {

    if ( email.isEmpty) {
      return 'حقل اجباري';
    }

    if (EmailValidator.validate(email.trim()) == false) {
      return "البريد الالكتروني غير صالح";
    }
    return null;
  }


//valid Password data============================================================
  static String? validatorPassword(pass) {
    if (pass.isEmpty) {
      return 'حقل اجباري';
    }
    if (pass.length < 6) {
      return "كلمة المرور ضعيفة";
    } else {
      return null;
    }
  }

//valid Phone data============================================================
  static String? validatorPhone(phone) {
    final phoneRegExp = RegExp(r"^\s*[0-9]{10}$");
    if (phone.trim().isEmpty) {
      return 'حقل اجباري';
    }
    if (phoneRegExp.hasMatch(phone) == false ||
        phone.startsWith('05') == false) {
      return "رقم الجوال غير صالح";
    }
    return null;
  }
}
