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
  static List list = ['الاختناق', 'ضيق النفس', 'اغماء', 'حرق', 'نزيف', 'تشنج'];
}
