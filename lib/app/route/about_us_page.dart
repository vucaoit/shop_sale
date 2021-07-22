import 'package:flutter/material.dart';
import 'package:get/get.dart';
class about_us_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("THIS IS ABOUT US PAGE"),
          ),
        ),
      ),
    );
  }
}