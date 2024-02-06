// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getxdemo/chat_apk/screesns/regster_screen.dart';
import 'package:getxdemo/chat_apk/screesns/sign_in.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return SiginPage(onTap: togglePages);
    } else {
      return RegisterScreen(
        onTap: togglePages,
      );
    }
  }
}
