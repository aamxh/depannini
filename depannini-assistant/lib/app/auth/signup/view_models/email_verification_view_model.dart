import 'package:get/get.dart';

class EmailVerificationVM extends GetxController {

  RxString code = ''.obs;
  RxString email = ''.obs;

  void changeCode(String code) => this.code.value = code;

  void changeEmail(String email) => this.email.value = email;

  bool get isValid {
    if (!code.value.isNum) return false;
    if (code.value.length != 5) return false;
    return true;
  }

}