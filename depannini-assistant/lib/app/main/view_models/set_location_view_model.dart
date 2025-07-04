import 'package:depannini_assistant/app/common/location_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationVM extends GetxController {

  final Rx<LatLng?> _location = LatLng(0, 0).obs;
  final Rx<String> _address = ''.obs;

  set location(LatLng? newLocation) => _location.value = newLocation;

  LatLng? get location => _location.value;
  String get address => _address.value;
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