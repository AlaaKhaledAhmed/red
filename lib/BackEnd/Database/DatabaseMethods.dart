import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppWidget.dart';

class Database {

  static Future<String> singUp({
    required String name,
    required String email,
    required String password,
    required String address,
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
          'address': address,
          'type': "pation",
         
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

  static Future<String> logging(
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
}