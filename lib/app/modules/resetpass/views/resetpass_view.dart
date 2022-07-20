import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lastcoffee/app/color_pallete.dart';

import '../../../auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/resetpass_controller.dart';

class ResetpassView extends GetView<ResetpassController> {
  ResetpassView({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      body: Container(
        height: Get.height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_clock_rounded,
              size: Get.width * 0.6,
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address", //babel text
                    hintText: "Enter your email", //hint text
                    prefixIcon: Icon(Icons.mail_outline_rounded), //prefix iocn
                    hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold), //hint text style
                    labelStyle: TextStyle(
                        fontSize: 15, color: appBgBlack), //label style
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: "Ingin Login ?",
                  style: const TextStyle(
                      height: 1,
                      fontSize: 15,
                      color: appRed,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = (() => Get.toNamed(Routes.AUTHPAGE)),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                  color: appRed,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ElevatedButton(
                  onPressed: () =>
                      authController.resetpass(controller.emailController.text),
                  style: ElevatedButton.styleFrom(
                      primary: appButtonColor,
                      onPrimary: appBgWhite,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
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
    );
  }
}
