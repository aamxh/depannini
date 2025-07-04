import 'package:get/get.dart';

class PhoneNumberVerificationVM extends GetxController {

  RxString code = ''.obs;

  void changeCode(String code) => this.code.value = code;

  bool get isValid {
    if (code.value.length != 5) return false;
    if (!code.value.isNum) return false;
    return true;
  }

}