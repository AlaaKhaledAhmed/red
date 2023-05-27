import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstants {
  static int statusIsSend = 1;
  static int statusIsAccept = 2;
  static int statusIsReject = 3;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('request');
  static String c1="";
  
  
  static List list = ['الاختناق', 'ضيق النفس', 'اغماء', 'حرق', 'نزيف', 'تشنج'];
  static List body = [
    "1الوقوف خلف الشخص المصاب لتحقيق التوازن-2وضع إحدى القدمين أمام األخرى قليالً-3 لف الذراعين حول خصر الشخص المصاب -4إمالة الشخص المصاب إلى األمام قليالً.5 عمل قبضة باليد األخرى ثم وضعها فوق منطقة السرة -6 مسك القبضة باليد األخرى ثم توجيه ضغطة بقوة على البطن بسرعة نحو األعلى -7 القيام بمعدل 6 إلى 10 ضغطات بطنية حتى يزول الجسم العالق -8 أما في حال كان الشخص المصاب قد فقد وعيه فقم باإلنعاش",
    "",
    "",
    "",
    "",
    ""
  ];
}

