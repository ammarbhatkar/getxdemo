import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" 2 page"),
      ),
      body: Column(
        children: [
          Text(Get.parameters['a'].toString()),
          InkWell(
            onTap: () {
              Get.offNamed("/third");
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: Text("2 page"),
            ),
          )
        ],
      ),
    );
  }
}
