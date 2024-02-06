import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? "")) {
      return "Email is not verified";
    }
    return null;
  }

  validatePassword(String? pwd) {
    if (!GetUtils.isLengthGreaterOrEqual(pwd, 6)) {
      return "Password is not valid";
    }
    return null;
  }

  Future onLogin() async {
    if (formKey.currentState!.validate()) {
      Get.snackbar(
        "sucess",
        "login sucessfull",
        backgroundColor: Colors.green,
      );
      return;
    }

    Get.snackbar(
      "error",
      "login failed",
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}
