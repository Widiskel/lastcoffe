import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthpageController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isHidden2 = true.obs;

  RxString lab = "Login".obs;
  String tabonchange(int idx) {
    if (idx == 0) {
      lab.value = "Login";
      return "Login";
    } else {
      lab.value = "Sign-up";
      return "Sign-Up";
    }
    // print("will be returned ${lab}");
  }

  //login
  TextEditingController emailController =
      TextEditingController(text: 'animemusic2017@gmail.com');
  TextEditingController passController = TextEditingController(text: '123123');

  //signup
  TextEditingController nameSController =
      TextEditingController(text: 'Widianto Eka S');
  TextEditingController addressSController =
      TextEditingController(text: 'Tuban');
  TextEditingController notelpSController =
      TextEditingController(text: '089697793005');
  TextEditingController emailSController =
      TextEditingController(text: 'animemusic2017@gmail.com');
  TextEditingController passSController = TextEditingController(text: '123123');

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    passSController.dispose();
    emailSController.dispose();
    notelpSController.dispose();
    addressSController.dispose();
    nameSController.dispose();
    super.onClose();
  }
}
