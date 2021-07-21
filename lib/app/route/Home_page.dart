import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shop_sale/app/data/provider/firebase/authentication.dart';
import 'package:shop_sale/app/globlal_widgets/footer.dart';
import 'package:shop_sale/app/route/cart_page.dart';

class Home_page extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var signUpClick = false.obs;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {},
            child: CircleAvatar(
              child: Image(
                image: AssetImage("assets/images/product/productimage.png"),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: _buildDrawer(),
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
                    validator: (value){
                      if(value!.isEmpty||value.length<6)return "require and more than 6 letter";
                          else return null;
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
                    "Register", Colors.white, Colors.blue, Colors.black, () {
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
                              confirmPasswordController.text.isNotEmpty)){
                        AuthController().signUp(nameController.text, userController.text, passwordController.text);
                        confirmPasswordController.text='';
                        nameController.text='';
                      }
                        else{
                        Get.snackbar("Register Fail",
                            "name not empty and email mustn't fake Password more than 6 letters",
                            duration: Duration(seconds: 4),
                            backgroundColor: Colors.grey,
                            barBlur: 2);
                      }
                    }
                  })
                : _customButton(
                    "LOGIN", Colors.white, Colors.blue, Colors.black, () {
                      if (GetUtils.isEmail(userController.text) &&
                userController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty
                      &&passwordController.text.length>5
                      ){
              AuthController().signIn(userController.text, passwordController.text);
              // passwordController.text='';
              // userController.text='';
            }
            else{
              Get.snackbar("Login Fail",
                  "email mustn't fake and Password more than 6 letters",
                  duration: Duration(seconds: 4),
                  backgroundColor: Colors.grey,
                  barBlur: 2);
            }})),
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
}
