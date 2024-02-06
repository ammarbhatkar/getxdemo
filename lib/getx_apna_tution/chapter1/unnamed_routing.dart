// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getxdemo/getx_apna_tution/chapter1/next.dart';

class UnNamedRoute extends StatelessWidget {
  const UnNamedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Un-named route 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Get.offAll(NextPage());

                // Get.off(NextPage());

                // var a = await Get.to(() => NextPage());
                // print(a);

                // Get.to(() => NextPage(), arguments: "Hello from route 1 ");

                // Get.to(
                //   () => NextPage(),
                //   transition: Transition.leftToRightWithFade,
                //   // duration: Duration(milliseconds: 3000),
                //   // curve: Curves.bounceInOut,
                //   // popGesture: true,
                // );
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Text("Navigate to next page")
          ],
        ),
      ),
    );
  }
}
