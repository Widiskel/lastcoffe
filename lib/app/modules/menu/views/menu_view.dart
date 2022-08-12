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
    return Obx(
      () => Scaffold(
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: appBg),
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
                          height: Get.height * 0.13,
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
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot<Object?>> coffeedata =
                              snapshot.data!.docs;

                          List listimg = [];
                          for (var element in coffeedata) {
                            listimg.add(element['img']);
                          }

                          return FutureBuilder(
                            future: controller.getImg(listimg),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text(
                                        "Error , please check your internet connection"));
                              }
                              if (snapshot.hasData) {
                                return SizedBox(
                                  height: Get.height * 0.3,
                                  child: ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(
                                      dragDevices: {
                                        PointerDeviceKind.touch,
                                        PointerDeviceKind.mouse,
                                      },
                                    ),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: coffeedata.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: appBgBlack,
                                              // border: Border.all(
                                              //     color: appBgBlack, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                "${snapshot.data[index]}"),
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    coffeedata[index]['name'],
                                                    style: const TextStyle(
                                                        color: appBgWhite,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
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
      ),
    );
  }
}
