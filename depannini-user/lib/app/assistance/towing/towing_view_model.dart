import 'package:get/get.dart';

class TowingVM extends GetxController {

  final Rx<String> _addressFrom = ''.obs, _addressTo = ''.obs;
  final Rx<bool> _isHeavy = false.obs;

  String get addressFrom => _addressFrom.value;

  String get addressTo => _addressTo.value;

  bool get isHeavy => _isHeavy.value;

  void changeAddressFrom(String val) => _addressFrom.value = val;

  void changeAddressTo(String val) => _addressTo.value = val;

  void changeIsHeavy(bool val) => _isHeavy.value = val;

  bool isReady() {
    if (addressTo.isEmpty) return false;
    if (addressFrom.isEmpty) return false;
    return true;
  }

}