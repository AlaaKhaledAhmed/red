import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          'type': "patient",
          'phone': phone
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

//====================================================
  static Future<String> sendRequest(
      {required String userId,
      required String userStatus,
      required double lang,
      required double lat,
      required int requestFrom,
      required String hospitalId,
      required String medicalRecordFile,
      required String phone}) async {
    try {
      AppConstants.requestCollection.add({
        'userId': userId,
        'userStatus': userStatus,
        'status': AppConstants.statusIsSend,
        'phone': phone,
        'lang': lang,
        'lat': lat,
        'requestFrom': requestFrom,
        'hospitalId': hospitalId,
        'to': 'redCrescent',
        'createdOn': FieldValue.serverTimestamp(),
        'hospitalName': '',
        
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
  //=======================updateRequest======================================

  static updateRequest({required String hospitalName,required String hospitalId, docId, required int status}) {
    try {
      AppConstants.requestCollection.doc(docId).update({

        'status': AppConstants.statusIsAcceptFromRed,
        'hospitalId': hospitalId,
        'createdOn': FieldValue.serverTimestamp(),
        'hospitalName': hospitalName
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
//=======================updateRequest======================================

  static updateRequestStuts({docId, required int status}) {
    try {
      AppConstants.requestCollection.doc(docId).update({
        'status': status,       
        'createdOn': FieldValue.serverTimestamp(),
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
  //=======================get Current Location======================================
  static Future getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "locationNotEnable";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return 'PERMISSION_DENIED';
      }
    }
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
      interval: 100000,
    );
    locationData = await location.getLocation();
    return locationData;
  }

  //open user location=========================================================
  static void showUserLocation(
      {required double latitude, required double longitude}) async {
    var url =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    try {
      await launch(url.toString());
    } catch (e) {
      print('Error in show user location: ${e.toString()}');
    }
  }

//update profile======================================================================
  static Future<String> updateProfile(
      {required String name,
      required String address,
      required String phone,
      required String docId}) async {
    try {
      await AppConstants.userCollection
          .doc(docId)
          .update({'name': name, 'address': address, 'phone': phone});
      return 'done';
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

  //====================================================
  static Future<String> addMedicalRecord({
    required String userId,
    required String hospitalId,
    required String disease,
    required String sensitive,
    required String bloodType,
  }) async {
    try {
      AppConstants.medicalRecordCollection.add({
        'userId': userId,
        'hospitalId': hospitalId,
        'disease': disease,
        'sensitive': sensitive,
        'bloodType': bloodType,
        'createdOn': FieldValue.serverTimestamp(),
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  //====================================================
  static Future<String> updateMedicalRecord({
    required String docId,
    required String hospitalId,
    required String disease,
    required String sensitive,
    required String bloodType,
  }) async {
    try {
      AppConstants.medicalRecordCollection.doc(docId).update({
        'hospitalId': hospitalId,
        'disease': disease,
        'sensitive': sensitive,
        'bloodType': bloodType,
      });
      return 'done';
    } catch (e) {
      return 'error';
    }
  }

  //=======================Delete  method======================================
  static Future<String> delete({
    required String docId,
    required String collection,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(docId)
          .delete();
      return 'done';
    } catch (e) {
      return 'error';
    }
  }
}
