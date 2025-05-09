import 'package:depannini_user/app/assistance/location_repo.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationVM extends GetxController {

  final Rx<LatLng?> _location = LatLng(0, 0).obs;
  final Rx<String> _address = ''.obs;
  final Rx<int> _id = 0.obs;

  LatLng? get location => _location.value;

  String get address => _address.value;

  int get id => _id.value;

  void changeLocation(LatLng newLocation) => _location.value = newLocation;

  Future<void> changeAddress(LatLng newLocation) async {
    final newAddress = await MyLocationRepo.getLocationDescription(newLocation);
    _address.value = newAddress ?? 'Location not specified.';
  }

  void changeId(int val) => _id.value = val;

  bool isAddressValid() {
    if (address == 'Location not specified.') return false;
    return true;
  }

}