import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt n = 6.obs;
  RxString name = "".obs;
  RxBool isSet = false.obs;
  RxDouble roll = 0.0.obs;

  void increase() {
    n++;
    print(n);
  }

  void decrease() {
    n--;
    print(n);
  }
}
