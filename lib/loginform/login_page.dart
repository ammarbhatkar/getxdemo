// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/loginform/custom_textfield.dart';
import 'package:getxdemo/loginform/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(height: 20),
              CustomTextField(
                hintText: "enter email",
                validator: (email) => controller.validateEmail(email),
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Enter password",
                validator: (pwd) => controller.validatePassword(pwd),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  controller.onLogin();
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
