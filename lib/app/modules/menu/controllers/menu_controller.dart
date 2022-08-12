import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../auth_controller.dart';

class MenuController extends GetxController {
  @override
  Future<void> onInit() async {
    final authController = Get.find<AuthController>();
    authController.getuserinfo();
    uemail.value = authController.em;
    super.onInit();
  }

  RxString uemail = ''.obs;
  FirebaseFirestore db = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> cfstream =
      FirebaseFirestore.instance.collection('coffee').snapshots();
}
