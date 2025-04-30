import 'package:depannini_user/app/assistance/location_repo.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationVM extends GetxController {

  Rx<LatLng?> location = LatLng(0, 0).obs;
  Rx<String> address = ''.obs;
  Rx<bool> isAddressValid = false.obs;

  void changeLocation(LatLng newLocation) => location.value = newLocation;

  Future<void> changeAddress(LatLng newLocation) async {
    final newAddress = await MyLocationRepo.getLocationDescription(newLocation);
    address.value = newAddress ?? 'Location not specified.';
  }

  void changeIsAddressValid(bool val) => isAddressValid.value = val;

}