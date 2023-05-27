import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:red_crescent/Widget/AppConstants.dart';
import 'package:red_crescent/Widget/AppWidget.dart';
import 'package:location/location.dart';

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

//====================================================
  static Future<String> sendRequest({
    required String userId,
    required String userStatus,
    required double lang,
    required double lat,
  }) async {
    try {
      AppConstants.requestCollection.add({
        'userId': userId,
        'userStatus': userStatus,
        'status': AppConstants.statusIsSend,
        'lang': lang,
        'lat': lat,
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
  void showUserLocation(
      {required double latitude, required double longitude}) async {
    var url =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    try {
      launch(url.toString());
    } catch (e) {}
  }
}
