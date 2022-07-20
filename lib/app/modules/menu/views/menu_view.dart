import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lastcoffee/app/color_pallete.dart';

import '../../../auth_controller.dart';
import '../controllers/menu_controller.dart';

class MenuView extends GetView<MenuController> {
  MenuView({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: appBgBlack,
            centerTitle: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: appBlack),
                ),
                Text(
                  controller.uemail.value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: appBg),
                )
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_rounded),
                onPressed: () {
                  authController.signout();
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_rounded),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              backgroundColor: appBgBlack,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Coffe',
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: appBgBlack,
                        height: Get.height * 0.12,
                      ),
                      Container(
                        color: appBg,
                        height: Get.height * 0.12,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: Get.height * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: AssetImage('assets/img/promo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: appBg,
                child: StreamBuilder<QuerySnapshot>(
                    stream: controller.cfstream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      return Container(
                        width: Get.width * 0.3,
                        height: Get.height * 0.3,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView(
                            padding: const EdgeInsets.all(10),
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  // print(data);
                                  return Container(
                                    width: Get.width * 0.4,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: appBlack, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            width: Get.width,
                                            color: appButtonColor,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${data['img']}"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(data['name'].toString()),
                                        )
                                      ],
                                    ),
                                  );
                                })
                                .toList()
                                .cast(),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: 1000,
                color: appBg,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
   // const Text("email"),
            // Center(child: Text(controller.uemail.value)),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () => authController.signout(),
            //     child: const Text('Sign Out'),
            //   ),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     // Get.toNamed(Routes.PROFIL,
            //     //     arguments: controller.uemail.value),
            //     child: const Text('profile'),
            //   ),
            // ),