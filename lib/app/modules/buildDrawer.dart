import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_sale/app/data/provider/firebase/authentication.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class BuildDrawer extends GetWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var signUpClick = false.obs;
  var checkLogin = false.obs;
  var user = 'username'.obs;
  var email = 'email'.obs;
  var reload = 0.obs;
  final userdata = GetStorage().obs;
  final ImagePicker _picker = ImagePicker();
  void _clearForm() {
    userController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    nameController.text = '';
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => (reload % 2 == 0)
        ? ((userdata.value.read("isLogged")
            ? _buildDrawerLogged()
            : _buildDrawer()))
        : ((userdata.value.read("isLogged")
            ? _buildDrawerLogged()
            : _buildDrawer())));
  }

  Widget _buildDrawerLogged() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Container(
              child: InkWell(
            onTap: () async {
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              await userdata.value.write("filepath", image!.path.toString());
            },
            child: Obx(() => (userdata.value
                    .read("filepath")==null)
                ? (ClipOval(

                child: Container(
                  height: 90,
                  width: 90,
                  child: Image(
                    image: AssetImage("assets/images/avata.png"),
                    fit: BoxFit.cover,
                  ),
                ),

            ))
                : (ClipOval(
              child: Container(
                height: 90,
                  width: 90,
                  child: Image.file(File(userdata.value.read("filepath")),fit: BoxFit.cover,),
              ),
            ))),
          )),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  child: _customText(userdata.value.read("username"), 20,
                      Colors.black, FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: _customText(userdata.value.read("email"), 17,
                      Colors.black, FontWeight.normal),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: _buildDrawerCategory(),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: FlatButton(
                    onPressed: () {
                      userdata.value.write("isLogged", false);
                      reload++;
                      userdata.value.remove("username");
                      userdata.value.remove("email");
                      userdata.value.remove("username");
                    },
                    child: _customText(
                        "Log out", 20, Colors.black, FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      child: Column(
        children: [
          _buildLoginForm(),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: _customText("Forget your password ?", 15,
                        Colors.black, FontWeight.bold)),
                Obx(() => (signUpClick.value)
                    ? TextButton(
                        onPressed: () {
                          signUpClick.value = false;
                          confirmPasswordController.text = '';
                        },
                        child: _customText(
                            "LOGIN", 15, Colors.blue, FontWeight.bold))
                    : TextButton(
                        onPressed: () {
                          signUpClick.value = true;
                        },
                        child: _customText(
                            "Register", 15, Colors.blue, FontWeight.bold)))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(.3),
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (!GetUtils.isEmail(value!))
                  return "Email is not valid";
                else
                  return null;
              },
              controller: userController,
              decoration: InputDecoration(
                  icon: Icon(Icons.email_outlined),
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  hintText: "Email"),
            ),
          ),
          Obx(() => (signUpClick.value)
              ? Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(.3),
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6)
                        return "require and more than 6 letter";
                      else
                        return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        hintText: "Name"),
                  ),
                )
              : Text("")),
          Container(
            //password
            padding: EdgeInsets.only(left: 10, right: 10),
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(.3),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Obx(
                        () => TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.length < 6 || value.isEmpty) {
                              if (value.length < 6)
                                return "password more than 6 letters";
                              else
                                return "require!!!";
                            }
                          },
                          obscureText: !showPassword.value,
                          controller: passwordController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.https_outlined),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              hintText: "Password"),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Obx(() => IconButton(
                            onPressed: () {
                              showPassword.value = (!showPassword.value);
                            },
                            icon: (showPassword.value)
                                ? Icon(Icons.remove_red_eye_outlined)
                                : Icon(Icons.remove_red_eye))))
                  ],
                )
              ],
            ),
          ),
          Obx(() => (signUpClick.value)
              ? Container(
                  //confirm password
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(.3),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Obx(
                              () => TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (passwordController.text != value)
                                    return "Password no math";
                                  else
                                    return null;
                                },
                                obscureText: !showConfirmPassword.value,
                                controller: confirmPasswordController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.https_outlined),
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: "Confirm Password"),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Obx(() => IconButton(
                                  onPressed: () {
                                    showConfirmPassword.value =
                                        (!showConfirmPassword.value);
                                  },
                                  icon: (showConfirmPassword.value)
                                      ? Icon(Icons.remove_red_eye_outlined)
                                      : Icon(Icons.remove_red_eye))))
                        ],
                      )
                    ],
                  ),
                )
              : Text("")),
          Container(
            padding: EdgeInsets.only(top: 20),
            margin: EdgeInsets.only(left: 50, right: 50),
            child: Obx(() => (signUpClick.value)
                ? _customButton(
                    "Register", Colors.white, Colors.blue, Colors.black,
                    () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      Get.snackbar(
                        "Register fail",
                        "Password no math",
                        duration: Duration(seconds: 3),
                      );
                    } else {
                      //register
                      if (GetUtils.isEmail(userController.text) &&
                          passwordController.text ==
                              confirmPasswordController.text &&
                          (userController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              confirmPasswordController.text.isNotEmpty)) {
                        await AuthController()
                            .signUp(nameController.text, userController.text,
                                passwordController.text)
                            .then((value) async {
                          _clearForm();
                          reload++;
                          signUpClick.value = false;
                        });
                      } else {
                        Get.snackbar("Register Fail",
                            "name not empty and email mustn't fake Password more than 6 letters",
                            duration: Duration(seconds: 4),
                            backgroundColor: Colors.grey,
                            barBlur: 2);
                      }
                    }
                  })
                : _customButton(
                    "LOGIN", Colors.white, Colors.blue, Colors.black, () async {
                    if (GetUtils.isEmail(userController.text) &&
                        userController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        passwordController.text.length > 5) {
                      final au = await AuthController()
                          .signIn(userController.text, passwordController.text)
                          .then((value) async {
                        _clearForm();
                        reload++;
                        checkLogin.value = true;
                      });

                      // passwordController.text='';
                      // userController.text='';
                    } else {
                      Get.snackbar("Login Fail",
                          "email mustn't fake and Password more than 6 letters",
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.grey,
                          barBlur: 2);
                    }
                  })),
          )
        ],
      ),
    );
  }

  Widget _customButton(String text, Color txtColor, Color bgColor,
      Color shadowColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        color: Colors.grey.withOpacity(.4),
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor,
            ),
            child: Container(
                margin: EdgeInsets.all(14),
                alignment: Alignment.center,
                child: _customText(
                  text,
                  18,
                  txtColor,
                  FontWeight.normal,
                ))),
      ),
    );
  }

  Widget _customText(String text, double size, Color color, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
    );
  }
  Widget _buildDrawerCategory(){
    return Container(
      child: Column(
        children: [
          Container(
            child: _buildBodyItemMenu(Icons.account_circle_rounded, "Profile", () { }),
          ),
          Container(
            child: _buildBodyItemMenu(Icons.assignment_outlined, "Your Order", () { }),
          ),
          Container(
            child: _buildBodyItemMenu(Icons.shopping_cart, "Your Cart", () { }),
          ),
          Container(
            child: _buildBodyItemMenu(Icons.volunteer_activism, "Wish List", () { }),
          ),
          Container(
            child: _buildBodyItemMenu(Icons.info, "About Us", () { }),
          ),
        ],
      ),
    );
  }
  _buildBodyItemMenu(IconData icon, String text, VoidCallback onclick) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 30,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black,fontSize: 20),
      ),
      onTap: onclick,
    );
  }
}
