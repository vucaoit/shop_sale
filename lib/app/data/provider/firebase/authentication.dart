import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'userController.dart';
import '../../model/user.dart';

class AuthController extends GetxController {

  var email=''.obs;
  var password = ''.obs;
  var name = ''.obs;
  String usersCollection = "users";
  void signIn(String email,String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      Get.defaultDialog(
          title: "Loading...",
          content: CircularProgressIndicator(),
          barrierDismissible: false
      );
      await Future.delayed(Duration(seconds: 3));
      // Dismiss CircularProgressIndicator
      Get.back();
      await auth
          .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((result) {
        Get.defaultDialog(
            title: "LOGIN COMPLETED",
            content: Text("Welcome to my app"),
        );
        _clearControllers();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp(String name,String email,String password) async {
    FirebaseAuth auth1 = FirebaseAuth.instance;
    showLoading();
    try {
      await auth1
          .createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((result) {
        String _userId = result.user!.uid;
        addUserToFirestore(_userId,name,email,password);
        _clearControllers();
        dismissLoadingWidget();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }
  _clearControllers() {
    name=''.obs;
    email=''.obs;
    password=''.obs;
  }

  addUserToFirestore(String userId,String name,String email,String password) {
    FirebaseFirestore.instance.collection(usersCollection).doc(userId).set({
      "name": name.trim(),
      "id": userId,
      "email": email.trim(),
      "password":password
    });
  }
  showLoading() async {
    Get.defaultDialog(
        title: "Loading...",
        content: CircularProgressIndicator(),
        barrierDismissible: false
    );
    await Future.delayed(Duration(seconds: 3));
    // Dismiss CircularProgressIndicator
    Get.back();
    Get.snackbar("Register Completed", "Login now");
  }

  dismissLoadingWidget(){
    Get.back();
  }
}
