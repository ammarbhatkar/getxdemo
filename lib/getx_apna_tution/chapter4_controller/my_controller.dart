// ignore_for_file: avoid_print

import 'package:get/get.dart';

class MyController extends GetxController {
  var count = 0.obs;

  incrementCOunter() {
    count++;
    print("count is called");
  }
}
