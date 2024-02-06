// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactiveManagement extends StatelessWidget {
  ReactiveManagement({super.key});
  var count = 0.obs;

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
              () => Text("$count"),
            ),
            ElevatedButton(
              onPressed: () {
                count++;
                print(count);
              },
              child: Text("icrement"),
            ),
          ],
        ),
      ),
    );
  }
}
