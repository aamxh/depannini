import 'package:get/get.dart';

class PhoneNumberVerificationVM extends GetxController {

  final Rx<String> _code = ''.obs;

  set code(String val) => _code.value = val;

  String get code => _code.value;

  bool isCodeValid() {
    if (!code.isNum) return false;
    if (code.length != 5) return false;
    return true;
  }

}