import 'package:depannini_user/app/assistance/set_location_view_model.dart';
import 'package:depannini_user/core/api_keys.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyLocationRepo {

  MyLocationRepo._();

  static Future<LocationData?> getCurrentLocation() async {
    final location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) return null;
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }
    return await location.getLocation();
  }

  static Future<String?> getLocationDescription(LatLng latLng) async {
    final url = "${MyConstants.reverseGeoCodingApiBaseUrl}${latLng.latitude},"
        "${latLng.longitude}&key=$androidMapsSdkKey";
    final setLocationVM = SetLocationVM();
    setLocationVM.changeIsAddressValid(false);
    try {
      final Response<Map<String, dynamic>> res = await Dio().get(url);
      if (res.statusCode == 200) {
        final List results = res.data!['results'];
        if (results.isEmpty) return null;
        final String? address =  results[0]['formatted_address'];
        if (address == null) return null;
        setLocationVM.changeIsAddressValid(true);
        return address;
      }
      return null;
    } catch(ex) {
      return ex.toString();
    }
  }

}