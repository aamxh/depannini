import 'package:depannini_assistant/app/assistance/location_repo.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationVM extends GetxController {

  final Rx<LatLng> _location = LatLng(0, 0).obs;
  final RxString _address = ''.obs;

  LatLng get location => _location.value;

  String get address => _address.value;

  void changeLocation(LatLng latLng) => _location.value = latLng;

  Future<void> changeAddress(LatLng latLng) async {
    final newAdd = await MyLocationRepo.getLocationDescription(latLng);
    _address.value = newAdd ?? 'Location not specified.';
  }

  bool isAddressValid() {
    if (address == 'Location not specified.') return false;
    return true;
  }

}