import 'package:depannini_assistant/app/common/location_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationVM extends GetxController {

  final Rx<LatLng> _assistantLocation = LatLng(37.422, -122.084).obs;
  final Rx<LatLng> _clientLocation = LatLng(37.45, -122.05).obs;
  final RxSet<Polyline> _path = <Polyline>{}.obs;

  LatLng get clientLocation => _clientLocation.value;
  LatLng get assistantLocation => _assistantLocation.value;
  RxSet<Polyline> get path => _path;

  set clientLocation(LatLng val) => _clientLocation.value = val;
  set assistantLocation(LatLng val) => _assistantLocation.value = val;

  Future<void> setPath(LatLng start, LatLng end) async {
    final res = await LocationApi.getPath(start, end);
    _path.assignAll(res);
  }

  Future<void> initializeCurrentLocation() async {
    final locationData = await LocationApi.getCurrentLocation();
    if (locationData != null) {
      clientLocation = LatLng(locationData.latitude!, locationData.longitude!);
    }
  }

}