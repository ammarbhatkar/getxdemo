// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/pages/homepage.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => HomePage());
          },
          child: Text("Go to Home Page "),
        ),
      ),
    );
  }
}
