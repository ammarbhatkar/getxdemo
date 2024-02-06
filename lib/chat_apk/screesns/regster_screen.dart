// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getxdemo/chat_apk/services/auth/auth_service.dart';
import 'package:getxdemo/chat_apk/components/my_button.dart';
import 'package:getxdemo/chat_apk/components/my_textfield.dart';

class RegisterScreen extends StatelessWidget {
  final void Function()? onTap;
  RegisterScreen({super.key, this.onTap});

  final TextEditingController emailController = TextEditingController();

  //password controller
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  void register(BuildContext context) {
    //get AuthService
    final _auth = AuthService();

    // if teh password matches register user
    if (passwordController.text == confirmController.text) {
      try {
        _auth.signUpwithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
    }
  }

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
              "Lets create an sccount for you",
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

            SizedBox(height: 10),
            MyTextField(
              text: "confirm password",
              obsecureText: true,
              controller: confirmController,
            ),
            SizedBox(height: 25),

            //login button
            MyButton(
              text: "Register",
              onTap: () {
                register(context);
              },
            ),

            SizedBox(height: 25),
            //register button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Sign in!",
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
