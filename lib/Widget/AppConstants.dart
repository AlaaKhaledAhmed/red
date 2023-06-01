import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstants {
  static int statusIsSend = 1;
  static int statusIsAccept = 2;
  static int statusIsReject = 3;
  static int requestFromRed=1;
  static int requestFromPatient=2;
  static String requestToRed='redCrescent';
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

