import 'package:flutter/material.dart';
import 'package:get/get.dart';
class wish_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Wish List"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("THIS IS WISH LIST PAGE"),
          ),
        ),
      ),
    );
  }
}