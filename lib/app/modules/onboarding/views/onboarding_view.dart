import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lastcoffee/app/color_pallete.dart';
import 'package:lastcoffee/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BoardState(),
    );
  }
}

class BoardState extends StatefulWidget {
  const BoardState({Key? key}) : super(key: key);
  @override
  State<BoardState> createState() => _BoardStateState();
}

class _BoardStateState extends State<BoardState> {
  bool isPressed = false;
  Future firstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen == false && isPressed == false) {
      await prefs.setBool('seen', false);
    } else {
      await prefs.setBool('seen', true);
      main();
    }
    // print("Seeen $seen");
  }

  @override
  void initState() {
    firstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgBlack,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/imgbg.png"),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    isPressed = true;
                    firstTime();
                  },
                  backgroundColor: appButtonColor,
                  label: const Text("Getting Started"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
