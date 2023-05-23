import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppConstants {

  static CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

}
