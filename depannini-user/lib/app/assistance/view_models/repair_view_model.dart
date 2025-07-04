import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RepairVM extends GetxController {

  final Rx<String> _desc = ''.obs;
  final Rx<LatLng> _location = LatLng(0, 0).obs;
  final Rx<String> _address = ''.obs;

  set desc(String val) => _desc.value = val;
  set location(LatLng val) => _location.value = val;
  set address(String val) => _address.value = val;

  String get desc => _desc.value;
  LatLng get location => _location.value;
  String get address => _address.value;
  bool get isReady {
    if (address == '' || address == 'Location not specified.') return false;
    if (desc == '') return false;
    return true;
  }

}