import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstants {
  static int statusIsSend = 1;
  static int statusIsAcceptFromRed = 2;
  static int statusIsRejectFromRed = 3;
  static int statusIsAcceptFromHospital = 4;
  static int statusIsRejectFromHospital = 5;

  static int requestFromRed=1;
  static int requestFromPatient=2;
  static String requestToRed='redCrescent';
  static String requestToHospital='hospital';
  static int requestFromHospital=3;
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference requestCollection =
      FirebaseFirestore.instance.collection('request');
        static CollectionReference medicalRecordCollection =
      FirebaseFirestore.instance.collection('medicalRecord');
  static String c1="";
  
  
  static List list = ['الاختناق', 'ضيق النفس', 'اغماء', 'حرق', 'نزيف', 'تشنج'];
  
}

