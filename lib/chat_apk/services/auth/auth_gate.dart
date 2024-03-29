// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getxdemo/chat_apk/services/auth/login_or_register.dart';
import 'package:getxdemo/chat_apk/screesns/chat_home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatHomePage();
          } else {
            return LoginOrRegister();
          }
        },
      ),
    );
  }
}
