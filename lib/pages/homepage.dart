// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/controller/app_controller.dart';
import 'package:getxdemo/pages/about_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.put(AppController());
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      snackPosition: SnackPosition.BOTTOM,
                      "Download Completed",
                      "your song is downloaded",
                    );
                  },
                  child: Text("Snack Bar"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Dialog Box",
                          middleText: "this is dialogbox created from getx",
                          textConfirm: "Confirm",
                          textCancel: "cancel",
                          onConfirm: () {
                            Get.snackbar("confirmed", "pressed confirm");
                          },
                          content: Column(
                            children: [
                              Text("Are you sure you want to delete?"),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text("No"),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                    child: Text("Dialog Box")),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => AboutPage());
                  },
                  child: Text(
                    "Go to about page",
                  ),
                ),
                IconButton(
                  iconSize: 70,
                  onPressed: () {
                    appController.increase();
                  },
                  icon: Icon(
                    Icons.add,
                  ),
                ),
                Obx(
                  () => Text(
                    appController.n.toString(),
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.red,
                  iconSize: 70,
                  onPressed: () {
                    appController.decrease();
                  },
                  icon: Icon(Icons.minimize),
                ),
              ],
            ),
          ),
        ));
  }
}
