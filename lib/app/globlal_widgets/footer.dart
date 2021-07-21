import 'package:flutter/material.dart';

class footer extends StatelessWidget {
  String title='Home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
    );
  }
}
