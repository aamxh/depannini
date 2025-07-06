import 'package:depannini_user/app/assistance/common/location_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationVM extends GetxController {

  final Rx<LatLng> _userLocation = LatLng(34.052235, -118.243683).obs;
  final Rx<LatLng> _assistantLocation = LatLng(34.049345, -118.238081).obs;
  final RxSet<Polyline> _path = <Polyline>{}.obs;

  LatLng get userLocation => _userLocation.value;

  LatLng get assistantLocation => _assistantLocation.value;

  RxSet<Polyline> get path => _path;

  set userLocation(LatLng val) => _userLocation.value = val;

  set assistantLocation(LatLng val) => _assistantLocation.value = val;

  Future<void> setPath(LatLng start, LatLng end) async {
    final res = await LocationApi.getPath(start, end);
    _path.assignAll(res);
  }

  Future<void> initializeCurrentLocation() async {
    final locationData = await LocationApi.getCurrentLocation();
    if (locationData != null) {
      userLocation = LatLng(locationData.latitude!, locationData.longitude!);
    }
  }

}