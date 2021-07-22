import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shop_sale/app/data/provider/firebase/authentication.dart';
import 'package:shop_sale/app/globlal_widgets/footer.dart';
import 'package:shop_sale/app/modules/buildDrawer.dart';
import 'package:shop_sale/app/route/cart_page.dart';
import 'package:get_storage/get_storage.dart';

class Home_page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {},
            child: CircleAvatar(
              child: null,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
            child: BuildDrawer()
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}