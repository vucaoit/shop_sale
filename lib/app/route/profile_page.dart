import 'package:flutter/material.dart';
import 'package:get/get.dart';
class profile_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("THIS IS PROFILE PAGE"),
          ),
        ),
      ),
    );
  }
}