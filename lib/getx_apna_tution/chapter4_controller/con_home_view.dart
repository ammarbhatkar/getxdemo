// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/getx_apna_tution/chapter4_controller/my_controller.dart';

class ControllerHomeView extends StatelessWidget {
  ControllerHomeView({super.key});
  // var count = 0.obs;
  var myController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text("${myController.count}"),
            ),
            ElevatedButton(
              onPressed: () {
                myController.incrementCOunter();
              },
              child: Text("icrement"),
            ),
          ],
        ),
      ),
    );
  }
}
