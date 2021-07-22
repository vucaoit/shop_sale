import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'userController.dart';
import '../../model/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class AuthController extends GetxController {
  final userdata = GetStorage();
  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  String usersCollection = "users";
  Future<void> uploadExample() async {

    // ...
    // e.g. await uploadFile(filePath);
  }
  Future<bool> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    bool check=false;
    try {
      Get.defaultDialog(
          title: "Loading...",
          content: CircularProgressIndicator(),
          barrierDismissible: false);
      await Future.delayed(Duration(seconds: 3));
      // Dismiss CircularProgressIndicator

      await auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((result) async {
        final authen = await FirebaseFirestore.instance
            .collection(usersCollection)
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) {
          final nametemp = value.data() as Map<String, dynamic>;
          userdata.write('username', nametemp["name"]);
        });
        Get.back();
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'info',
            auth.currentUser!.email.toString() +
                ":" +
                auth.currentUser!.uid.toString());
        _clearControllers();
        await userdata.write('isLogged', true);
        await userdata.write('email', auth.currentUser!.email.toString());
        Future.delayed(Duration(seconds: 0), (){check= true;});
      });
    } catch (e) {
      Get.back();
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
      Future.delayed(Duration(seconds: 1), () {check= false;});
    }
    return check;
  }

  Future<bool> signUp(String name, String email, String password) async {
    FirebaseAuth auth1 = FirebaseAuth.instance;
    showLoading();
    try {
      await auth1
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((result) async {
        String _userId = result.user!.uid;
        await addUserToFirestore(_userId, name, email, password);
        await _clearControllers();
        await dismissLoadingWidget();
        Future.delayed(Duration(seconds: 0), (){return true;});
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
      Future.delayed(Duration(seconds: 1), (){return false;});
    }
    return false;
  }

  _clearControllers() {
    name = ''.obs;
    email = ''.obs;
    password = ''.obs;
  }

  addUserToFirestore(
      String userId, String name, String email, String password) {
    FirebaseFirestore.instance.collection(usersCollection).doc(userId).set({
      "name": name.trim(),
      "id": userId,
      "email": email.trim(),
      "password": password
    });
  }

  showLoading() async {
    Get.defaultDialog(
        title: "Loading...",
        content: CircularProgressIndicator(),
        barrierDismissible: false);
    await Future.delayed(Duration(seconds: 3));
    // Dismiss CircularProgressIndicator
    Get.back();
    Get.snackbar("Register Completed", "Login now");
  }

  dismissLoadingWidget() {
    Get.back();
  }
}
