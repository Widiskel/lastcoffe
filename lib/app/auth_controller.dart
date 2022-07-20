// ignore_for_file: avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lastcoffee/app/color_pallete.dart';
import 'package:lastcoffee/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  Stream<User?> get streamAuthState => auth.authStateChanges();

  void resetpass(String email) async {
    if (email != "" && GetUtils.isEmail(email.trim())) {
      try {
        print('email : ${email}');
        auth.sendPasswordResetEmail(email: email.trim());
        Get.defaultDialog(
          title: "Sukses",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          textConfirm: "Saya mengerti",
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          confirmTextColor: appBgWhite,
          barrierDismissible: true,
          buttonColor: appButtonColor,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Email link untuk mereset password telah dikirimkan ke ${email}, jika tidak ditemukan silahkan cek folder SPAM",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.defaultDialog(
            title: "Terjadi kesalahan",
            titleStyle: TextStyle(
              color: appBgBlack,
            ),
            radius: 30,
            onConfirm: () => Get.back(),
            titlePadding: EdgeInsets.only(top: 20),
            contentPadding: EdgeInsets.all(20),
            textConfirm: "Saya mengerti",
            confirmTextColor: appBgWhite,
            barrierDismissible: true,
            buttonColor: appButtonColor,
            backgroundColor: appTextColor,
            content: Container(
              alignment: Alignment.center,
              width: Get.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: appBgWhite,
                border: Border.all(
                  width: 2,
                  color: appButtonColor,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "User dengan email ${email} tidak ditemukan",
                style: TextStyle(fontSize: 15, color: appBgBlack),
              ),
            ),
          );
        }
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          textConfirm: "Saya mengerti",
          cancelTextColor: appBgWhite,
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          confirmTextColor: appBgWhite,
          barrierDismissible: true,
          buttonColor: appButtonColor,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Email tidak boleh kosong dan silahkan masukkan format alamat email dengan benar",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        titleStyle: TextStyle(
          color: appBgBlack,
        ),
        radius: 30,
        onConfirm: () => Get.back(),
        textConfirm: "Saya mengerti",
        cancelTextColor: appBgWhite,
        titlePadding: EdgeInsets.only(top: 20),
        contentPadding: EdgeInsets.all(20),
        confirmTextColor: appBgWhite,
        barrierDismissible: true,
        buttonColor: appButtonColor,
        backgroundColor: appTextColor,
        content: Container(
          alignment: Alignment.center,
          width: Get.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: appBgWhite,
            border: Border.all(
              width: 2,
              color: appButtonColor,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Email tidak boleh kosong dan silahkan masukkan format alamat email dengan benar",
            style: TextStyle(fontSize: 15, color: appBgBlack),
          ),
        ),
      );
    }
  }

  void login(String email, String password) async {
    try {
      print('${email}');
      print('${password}');
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      if (user.user!.emailVerified) {
        Get.toNamed(Routes.MENU);
      } else {
        Get.defaultDialog(
          title: "Email Not Verified",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          textConfirm: "Saya mengerti",
          textCancel: "Resend Verification",
          onCancel: () => user.user!.sendEmailVerification(),
          cancelTextColor: appBgWhite,
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          confirmTextColor: appBgWhite,
          barrierDismissible: true,
          buttonColor: appButtonColor,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Harap verifikasi email terlebih daulu, jika tidak ditemukan silahkan cek folder SPAM",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          textConfirm: "Saya mengerti",
          confirmTextColor: appBgWhite,
          barrierDismissible: true,
          buttonColor: appButtonColor,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "User dengan email ${email} tidak ditemukan",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          buttonColor: appButtonColor,
          onConfirm: () => Get.back(),
          confirmTextColor: appBgWhite,
          textConfirm: "Saya mengerti",
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          barrierDismissible: true,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Password anda salah",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      }
    }
  }

  Future<void> signout() async {
    await auth.signOut();
    Get.toNamed(Routes.AUTHPAGE);
  }

  void signup(String name, String address, String notelp, String email,
      String password) async {
    try {
      final adduser = <String, dynamic>{
        "Nama": name.trimRight(),
        "Alamat": address.trimRight(),
        "E-mail": email.trimRight(),
        "No HP": notelp.trim(),
        "Password": password,
      };

      // Add a new document with a generated ID
      db.collection("users").doc("$email").set(adduser);

      //signup
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Get.defaultDialog(
        title: "Registrasi berhasil\nSatu langkah lagi",
        titleStyle: TextStyle(
          color: appBgBlack,
        ),
        radius: 30,
        confirmTextColor: appBgWhite,
        onConfirm: () => Get.back(),
        textConfirm: "Saya mengerti",
        barrierDismissible: true,
        buttonColor: appButtonColor,
        titlePadding: EdgeInsets.only(top: 20),
        contentPadding: EdgeInsets.all(20),
        backgroundColor: appTextColor,
        content: Container(
          alignment: Alignment.center,
          width: Get.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: appBgWhite,
            border: Border.all(
              width: 2,
              color: appButtonColor,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Kami telah mengirimkan email verifikasi ke ${email}",
            style: TextStyle(fontSize: 15, color: appBgBlack),
          ),
        ),
      );
      await user.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          textConfirm: "Saya mengerti",
          confirmTextColor: appBgWhite,
          barrierDismissible: true,
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          buttonColor: appButtonColor,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Password anda terlalu lemah",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          titleStyle: TextStyle(
            color: appBgBlack,
          ),
          radius: 30,
          onConfirm: () => Get.back(),
          textConfirm: "Saya mengerti",
          barrierDismissible: true,
          titlePadding: EdgeInsets.only(top: 20),
          contentPadding: EdgeInsets.all(20),
          buttonColor: appButtonColor,
          confirmTextColor: appBgWhite,
          backgroundColor: appTextColor,
          content: Container(
            alignment: Alignment.center,
            width: Get.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appBgWhite,
              border: Border.all(
                width: 2,
                color: appButtonColor,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "Email telah terdaftar",
              style: TextStyle(fontSize: 15, color: appBgBlack),
            ),
          ),
        );
      }
    }
  }

  String em = "";
  void getuserinfo() {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        em = user.email.toString();
      } else {
        em = '';
      }
    });
    print('emaill ; $em');
  }
}
