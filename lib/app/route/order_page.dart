import 'package:flutter/material.dart';
import 'package:get/get.dart';
class order_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("THIS IS Order PAGE"),
          ),
        ),
      ),
    );
  }
}