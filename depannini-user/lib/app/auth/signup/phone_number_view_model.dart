import 'package:get/get.dart';

class PhoneNumberVM extends GetxController {

  String num = '';

  void changeNum(String val) {
    num = val;
    update();
  }

}