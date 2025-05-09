import 'package:get/get.dart';

class RepairVM extends GetxController {

  final Rx<String> _addressFrom = ''.obs;

  String get addressFrom => _addressFrom.value;

  void changeAddressFrom(String val) => _addressFrom.value = val;

  bool isReady() {
    if (addressFrom.isEmpty) return false;
    return true;
  }

}