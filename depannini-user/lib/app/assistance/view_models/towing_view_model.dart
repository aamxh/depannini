import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TowingVM extends GetxController {

  final Rx<bool> _isHeavy = false.obs;
  final Rx<LatLng> _fromLocation = LatLng(0, 0).obs;
  final Rx<LatLng> _toLocation = LatLng(0, 0).obs;
  final Rx<String> _fromAddress = ''.obs;
  final Rx<String> _toAddress = ''.obs;

  set isHeavy(bool val) => _isHeavy.value = val;
  set fromLocation(LatLng val) => _fromLocation.value = val;
  set toLocation(LatLng val) => _toLocation.value = val;
  set fromAddress(String val) => _fromAddress.value = val;
  set toAddress(String val) => _toAddress.value = val;

  bool get isHeavy => _isHeavy.value;
  LatLng get fromLocation => _fromLocation.value;
  LatLng get toLocation => _toLocation.value;
  String get fromAddress => _fromAddress.value;
  String get toAddress => _toAddress.value;
  bool get isReady {
    if (fromAddress == "Location not specified." || fromAddress.isEmpty) return false;
    if (toAddress == "Location not specified." || toAddress.isEmpty) return false;
    return true;
  }

}