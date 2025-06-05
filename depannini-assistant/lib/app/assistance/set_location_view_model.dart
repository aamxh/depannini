import 'package:depannini_assistant/app/assistance/location_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationVM extends GetxController {

  final Rx<int> _id = 0.obs;
  final Rx<LatLng?> _location = LatLng(0, 0).obs;
  final Rx<String> _address = ''.obs;

  set location(LatLng? newLocation) => _location.value = newLocation;
  set id(int val) => _id.value = val;

  LatLng? get location => _location.value;
  String get address => _address.value;
  int get id => _id.value;
  bool get isAddressValid => address == "Location not specified." || address.isEmpty ? false : true;

  Future<void> changeAddress(LatLng newLocation) async {
    final newAddress = await LocationApi.getLocationDescription(newLocation);
    if (newAddress == null) {
      _address.value = 'Location not specified.';
    } else {
      _address.value = newAddress;
    }
  }

}