import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssistantVM extends GetxController {

  final Rx<String> _name = ''.obs;
  final Rx<String> _email = ''.obs;
  final Rx<String> _password = ''.obs;
  final Rx<String> _num = ''.obs;
  final Rx<LatLng> _location = LatLng(0, 0).obs;
  final RxInt _serviceType = 0.obs;
  final RxInt _licenseCat = 0.obs;
  final RxInt _vehicleType = 0.obs;
  final Rx<String> _regNum = ''.obs;
  final Rx<String> _licenseNum = ''.obs;

  set name(String val) => _name.value = val;
  set num(String val) => _num.value = val;
  set email(String val) => _email.value = val;
  set password(String val) => _password.value = val;
  set location(LatLng val) => _location.value = val;
  set serviceType(int val) => _serviceType.value = val;
  set licenseCat(int val) => _licenseCat.value = val;
  set vehicleType(int val) => _vehicleType.value = val;
  set regNum(String val) => _regNum.value = val;
  set licenseNum(String val) => _licenseNum.value = val;

  String get name => _name.value;
  String get num => _name.value;
  String get password => _password.value;
  String get email => _email.value;
  LatLng get location => _location.value;
  int get serviceType => _serviceType.value;
  int get licenseCat => _licenseCat.value;
  int get vehicleType => _vehicleType.value;
  String get regNum => _regNum.value;
  String get licenseNum => _licenseNum.value;

}