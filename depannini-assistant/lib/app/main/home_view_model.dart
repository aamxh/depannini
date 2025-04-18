import 'package:get/get.dart';

class HomeVM extends GetxController {

  RxBool isActive = false.obs;

  void changeActiveState(int idx) {
    if (idx == 0) {
      isActive.value = false;
    }
    else {
      isActive.value = true;
    }
  }
}