import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lastcoffee/app/color_pallete.dart';
import 'package:lastcoffee/app/routes/app_pages.dart';

import '../../../auth_controller.dart';
import '../controllers/authpage_controller.dart';

class AuthpageView extends GetView<AuthpageController> {
  AuthpageView({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(
        () => MaterialApp(
          home: Scaffold(
            backgroundColor: appBg,
            body: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/authhead.png'),
                          fit: BoxFit.fill),
                    ),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/img/splashimg.png'),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: appBgBlack,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: TabBar(
                            onTap: (index) {
                              controller.tabonchange(index);
                            },
                            indicatorPadding: EdgeInsets.only(
                                left: Get.width * 0.08,
                                right: Get.width * 0.08,
                                top: Get.height * 0.043,
                                bottom: Get.height * 0.01),
                            indicator: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    bottomEnd: Radius.circular(30),
                                    bottomStart: Radius.circular(30),
                                  ),
                                ),
                                color: appButtonColor),
                            tabs: const <Widget>[
                              Tab(
                                text: "Login",
                              ),
                              Tab(
                                text: "Sign-Up",
                              ),
                            ],
                            labelColor: appBgWhite,
                            unselectedLabelColor: appBlack,
                            labelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: TabBarView(children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 35, left: 35),
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.69,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller:
                                                controller.emailController,
                                            decoration: const InputDecoration(
                                              labelText:
                                                  "Email Address", //babel text
                                              hintText:
                                                  "Enter your email", //hint text
                                              prefixIcon: Icon(Icons
                                                  .mail_outline_rounded), //prefix iocn
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight
                                                      .bold), //hint text style
                                              labelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      appBgBlack), //label style
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          controller: controller.passController,
                                          obscureText:
                                              controller.isHidden.value,
                                          decoration: InputDecoration(
                                            labelText: "Password", //babel text
                                            hintText:
                                                "Enter your password", //hint text
                                            prefixIcon: const Icon(Icons
                                                .key_outlined), //prefix iocn
                                            suffixIcon: IconButton(
                                              onPressed: () =>
                                                  controller.isHidden.toggle(),
                                              icon: const Icon(
                                                  Icons.remove_red_eye_rounded),
                                            ),
                                            hintStyle: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight
                                                    .bold), //hint text style
                                            labelStyle: const TextStyle(
                                                fontSize: 15,
                                                color:
                                                    appBgBlack), //label style
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Forgot password ?",
                                            style: const TextStyle(
                                                height: 1,
                                                fontSize: 15,
                                                color: appRed,
                                                fontWeight: FontWeight.bold),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (() {
                                                Get.toNamed(Routes.RESETPASS);
                                              }),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 35, left: 35),
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.69,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller:
                                                controller.nameSController,
                                            decoration: const InputDecoration(
                                              labelText:
                                                  "Nama Lengkap", //babel text
                                              hintText:
                                                  "Masukkan alamat lengkap anda", //hint text
                                              prefixIcon: Icon(Icons
                                                  .account_circle_rounded), //prefix iocn
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight
                                                      .bold), //hint text style
                                              labelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      appBgBlack), //label style
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller:
                                                controller.addressSController,
                                            decoration: const InputDecoration(
                                              labelText: "Alamat", //babel text
                                              hintText:
                                                  "Masukkan alamat anda", //hint text
                                              prefixIcon: Icon(Icons
                                                  .map_rounded), //prefix iocn
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight
                                                      .bold), //hint text style
                                              labelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      appBgBlack), //label style
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller:
                                                controller.notelpSController,
                                            decoration: const InputDecoration(
                                              labelText: "No Telp", //babel text
                                              hintText:
                                                  "Masukkan no HP anda", //hint text
                                              prefixIcon: Icon(Icons
                                                  .phone_android_rounded), //prefix iocn
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight
                                                      .bold), //hint text style
                                              labelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      appBgBlack), //label style
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: TextField(
                                            controller:
                                                controller.emailSController,
                                            decoration: const InputDecoration(
                                              labelText: "Email", //babel text
                                              hintText:
                                                  "Masukkan email anda", //hint text
                                              prefixIcon: Icon(Icons
                                                  .mail_outline_rounded), //prefix iocn
                                              hintStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight
                                                      .bold), //hint text style
                                              labelStyle: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      appBgBlack), //label style
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Flexible(
                                        child: TextField(
                                          obscureText:
                                              controller.isHidden2.value,
                                          controller:
                                              controller.passSController,
                                          decoration: InputDecoration(
                                            labelText: "Password", //babel text
                                            hintText:
                                                "Masukkan password anda", //hint text
                                            prefixIcon: const Icon(
                                                Icons.key_outlined), //prefix
                                            suffixIcon: IconButton(
                                                onPressed: () => controller
                                                    .isHidden2
                                                    .toggle(),
                                                icon: const Icon(Icons
                                                    .remove_red_eye_rounded)),
                                            hintStyle: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight
                                                    .bold), //hint text style
                                            labelStyle: const TextStyle(
                                                fontSize: 15,
                                                color:
                                                    appBgBlack), //label style
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    width: Get.width,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.lab.value == "Login") {
                          // print('Now login');
                          authController.login(controller.emailController.text,
                              controller.passController.text);
                        } else if (controller.lab.value == "Sign-up") {
                          // print('Now Sign Up');
                          authController.signup(
                              controller.nameSController.text,
                              controller.addressSController.text,
                              controller.notelpSController.text,
                              controller.emailSController.text,
                              controller.passSController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: appButtonColor,
                          onPrimary: appRed,
                          shape: const StadiumBorder()),
                      child: Text(
                        controller.lab.value,
                        style: const TextStyle(
                          height: 1,
                          fontSize: 15,
                          color: appBgWhite,
                          letterSpacing: -1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
