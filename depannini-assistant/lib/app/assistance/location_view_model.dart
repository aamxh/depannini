import 'dart:convert';
import 'package:depannini_assistant/app/assistance/location_api.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationVM extends GetxController {

  final Rx<LatLng> _userLocation = LatLng(37.422, -122.084).obs;
  final Rx<LatLng> _assistantLocation = LatLng(37.3861, -122.0839).obs;
  final Rx<String> _assistanceStatus = 'accepted'.obs;
  final Rx<String> _assistantPhoneNum = '0557038640'.obs;
  final RxSet<Polyline> _path = <Polyline>{}.obs;

  LatLng get userLocation => _userLocation.value;

  LatLng get assistantLocation => _assistantLocation.value;

  String get assistanceStatus => _assistanceStatus.value;

  String get assistantPhoneNum => _assistantPhoneNum.value;

  RxSet<Polyline> get path => _path;

  void setUserLocation(LatLng val) => _userLocation.value = val;

  void setAssistantLocation(LatLng val) => _assistantLocation.value = val;

  void setAssistanceStatus(String val) => _assistanceStatus.value = val;

  void setAssistantPhoneNum(String val) => _assistantPhoneNum.value = val;

  Future<void> setPath(LatLng start, LatLng end) async {
    final res = await LocationApi.getPath(start, end);
    _path.assignAll(res);
  }

  Future<void> initializeCurrentLocation() async {
    final locationData = await LocationApi.getCurrentLocation();
    if (locationData != null) {
      setUserLocation(LatLng(locationData.latitude!, locationData.longitude!));
    }
  }

}