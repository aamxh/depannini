import 'package:depannini_user/app/assistance/set_location_view_model.dart';
import 'package:depannini_user/core/api_keys.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationApi {

  LocationApi._();

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
    final setLocationVM = Get.find<SetLocationVM>();
    setLocationVM.isAddressValid = false;
    try {
      final Response<Map<String, dynamic>> res = await Dio().get(url);
      if (res.statusCode == 200) {
        final List results = res.data!['results'];
        if (results.isEmpty) return null;
        final String? address =  results[0]['formatted_address'];
        if (address == null) return null;
        setLocationVM.isAddressValid = true;
        return address;
      }
      return null;
    } catch(ex) {
      return ex.toString();
    }
  }

  static double getDistance(LatLng start, LatLng dest) {
    final distance = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        dest.latitude,
        dest.longitude,
    ) / 1000;
    return distance;
  }

  static Future<Set<Polyline>> getPath(LatLng start, LatLng end) async {

    final url = "${MyConstants.directionsApiBaseUrl}${start.latitude},${start.longitude}"
        "&destination=${end.latitude},${end.longitude}&key=$directionsKey";

    try {
      final res = await Dio().get(url);
      if (!MyHelpers.resIsOk(res.statusCode)) return {};
      final data = res.data;
      if (data['routes'].isEmpty) return {};
      final points = data['routes'][0]['overview_polyline']['points'];
      final decodedPoints = PolylinePoints().decodePolyline(points);
      final polylineCoordinates = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      return {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 4,
        ),
      };
    } catch (e) {
      debugPrint("Failed to fetch directions: $e");
      return {};
    }
  }


}