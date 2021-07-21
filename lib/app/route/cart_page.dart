import 'package:flutter/material.dart';
import 'package:get/get.dart';
class cart_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("THIS IS CART PAGE"),
          ),
        ),
      ),
    );
  }
}