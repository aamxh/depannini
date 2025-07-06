import 'package:get/get.dart';

class ClientVM extends GetxController {

  final Rx<String> _name = ''.obs;
  final Rx<String> _email = ''.obs;
  final Rx<String> _password = ''.obs;
  final Rx<String> _num = ''.obs;
  final Rx<double> _currentLat = 0.0.obs;
  final Rx<double> _currentLng = 0.0.obs;
  final Rx<String> _address = ''.obs;

  set name(String val) => _name.value = val;
  set num(String val) => _num.value = val;
  set email(String val) => _email.value = val;
  set password(String val) => _password.value = val;
  set address(String val) => _address.value = val;
  set currentLat(double val) => _currentLat.value = val;
  set currentLng(double val) => _currentLng.value = val;

  String get name => _name.value;
  String get num => _num.value;
  String get password => _password.value;
  String get address => _address.value;
  String get email => _email.value;
  double get currentLat => _currentLat.value;
  double get currentLng => _currentLng.value;

}