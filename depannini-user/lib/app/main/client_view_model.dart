import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientVM extends GetxController {

  final Rx<String> _name = ''.obs;
  final Rx<String> _email = ''.obs;
  final Rx<String> _password = ''.obs;
  final Rx<String> _num = ''.obs;
  final Rx<LatLng> _location = LatLng(0, 0).obs;

  set name(String val) => _name.value = val;
  set num(String val) => _num.value = val;
  set email(String val) => _email.value = val;
  set password(String val) => _password.value = val;
  set location(LatLng val) => _location.value = val;

  String get name => _name.value;
  String get num => _name.value;
  String get password => _password.value;
  String get email => _email.value;
  LatLng get location => _location.value;

}