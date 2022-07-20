// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lastcoffee/app/modules/onboarding/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    //jika dijalankan menggunakan web
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(
    AuthController(),
    permanent: true,
  );
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return StreamBuilder<User?>(
      stream: authC.streamAuthState,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          Future firstTime() async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            bool seen = (prefs.getBool('seen') ?? false);
            if (snapshot.data != null &&
                snapshot.data!.emailVerified == true &&
                seen == true) {
              Get.toNamed(Routes.MENU);
            } else if (seen == false) {
              Get.toNamed(Routes.ONBOARDING);
            } else {
              Get.toNamed(Routes.AUTHPAGE);
            }
          }

          firstTime();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Last Coffee",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.MENU
                    : Routes.AUTHPAGE,
            getPages: AppPages.routes,
          );
        } else {
          return const OnboardingView();
        }
      },
    );
  }
}
