import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppWidget.dart';

class Database {
  //=======================Student Sing up method======================================

  static Future<String> studentSingUpFu({
    required String name,
    required String email,
    required String password,
    required String stId,
    required String major,
    required String phone,
    required String searchInterest,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      if (userCredential.user != null) {
        await AppConstants.userCollection.add({
          'name': name,
          'userId': userCredential.user?.uid,
          'password': password,
          'email': email,
          'major': major,
          'stId': stId,
          'type': AppConstants.student,
          'searchInterest': searchInterest,
          'auth': ''
        });
        return 'done';
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password';
      }
      if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      }
    } catch (e) {
      return e.toString();
    }
    return 'error';
  }

  //=======================supervisor Sing up method======================================
  static Future<String> supervisorSingUpFu({
    required String name,
    required String email,
    required String password,
    required String searchInterest,
    required String major,
    required String phone,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      if (userCredential.user != null) {
        await AppConstants.userCollection.add({
          'name': name,
          'userId': userCredential.user?.uid,
          'password': password,
          'email': email,
          'major': major,
          'searchInterest': searchInterest,
          'type': AppConstants.supervisor
        });
        return 'done';
      }
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak-password';
      }
      if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      }
    } catch (e) {
      return e.toString();
    }
    return 'error';
  }

//=======================Log in method======================================

  static Future<String> loggingToApp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      if (userCredential.user != null) {
        return '${userCredential.user?.uid}';
        //
      }
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      }
      if (e.code == 'wrong-password') {
        return 'wrong-password';
      }
    } catch (e) {
      return 'error';
    }
    return 'error';
  }

//=======================Add team======================================
  static Future<String> addTeam(
      {required String name,
      required String stId,
      required String auth,
      required String userId}) async {
    try {} catch (e) {
      return e.toString();
    }

    return 'error';
  }

//get Student vi userId=============================================================================
  static Future<String> getDataViUserId(
      {required String currentUserUid}) async {
    String name = '';

    await AppConstants.userCollection
        .where('userId', isEqualTo: currentUserUid)
        .get()
        .then((getData) {
      getData.docs.forEach((element) {
        name = element['name'];
      });
    });
    return name;
  }

//get request status=============================================================================
  static Future<int> getStatus({required String id}) async {
    var status = 0;

    await AppConstants.requestCollection
        .where('studentUid', isEqualTo: id)
        .get()
        .then((getData) {
      getData.docs.forEach((element) {
        print('status: ${element.id}');
      });
      print('status: $status');
    });
    return status;
  }

  //student Supervision Requests=============================================================
  static Future studentSupervisionRequests({
    required BuildContext context,
    required String studentUid,
    required String supervisorUid,
    required String supervisorName,
    required String supervisorInterest,
    required String studentName,
  }) async {
    try {
      AppConstants.requestCollection.add({
        'studentUid': studentUid,
        'supervisorUid': supervisorUid,
        'status': AppConstants.statusIsWaiting,
        'requestId': AppWidget.uniqueOrder(),
        'supervisorName': supervisorName,
        'supervisorInterest': supervisorInterest,
        'studentName': studentName,
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
//==========================================================================
  static Future updateStatus({required int status,required String docId}) async {
    try {
      await AppConstants.requestCollection.doc(docId).update({'status': status});
      return 'done';
    } catch (e) {
      print('Update Status Error $e');
      return 'error';
    }
  }
}
