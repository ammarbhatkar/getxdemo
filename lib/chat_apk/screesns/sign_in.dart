// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:getxdemo/chat_apk/services/auth/auth_service.dart';

import 'package:getxdemo/chat_apk/components/my_button.dart';
import 'package:getxdemo/chat_apk/components/my_textfield.dart';

class SiginPage extends StatelessWidget {
  final void Function()? onTap;
  SiginPage({
    super.key,
    required this.onTap,
  });

  void login(BuildContext context) async {
    //get  auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInwithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    }
    //catch error
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  e.toString(),
                ),
              ));
    }
  }

  //email controller
  final TextEditingController emailController = TextEditingController();

  //password controller
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50),
            //welcome text
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25),
            //email textfield
            MyTextField(
              text: "email",
              obsecureText: false,
              controller: emailController,
            ),
            SizedBox(height: 10),
            //password textfield
            MyTextField(
              controller: passwordController,
              text: "password",
              obsecureText: true,
            ),

            SizedBox(height: 25),
            //login button
            MyButton(
              text: "Login",
              onTap: () {
                login(context);
              },
            ),

            SizedBox(height: 25),
            //register button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
