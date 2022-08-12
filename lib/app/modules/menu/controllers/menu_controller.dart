import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lastcoffee/app/routes/app_pages.dart';

import '../../../auth_controller.dart';

class MenuController extends GetxController {
  @override
  Future<void> onInit() async {
    final authController = Get.find<AuthController>();
    authController.getuserinfo();
    authController.em == ''
        ? Get.offAndToNamed(Routes.AUTHPAGE)
        : uemail.value = authController.em;
    super.onInit();
  }

  RxString uemail = ''.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> cfstream =
      FirebaseFirestore.instance.collection('coffee').snapshots();
  final storage = FirebaseStorage.instance;

  RxMap imglist = {}.obs;

  Future<List> getImg(List imglist) async {
    List url = [];
    for (var element in imglist) {
      final storageRef = FirebaseStorage.instance.ref();
      Reference? imagesRef = storageRef.child("coffee");
      final fileref = imagesRef.child(element);
      try {
        url.add(await fileref.getDownloadURL());
      } on FirebaseException catch (e) {
        if (kDebugMode) {
          print("Failed with error '${e.code}': ${e.message}");
        }
      }
    }
    // print('URL : $url');
    return url;
  }
}
