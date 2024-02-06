// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unknown page"),
      ),
      body: Center(
        child: Text("Unknown page"),
      ),
    );
  }
}
