import 'package:depannini_assistant/app/auth/common/auth_api.dart';
import 'package:depannini_assistant/app/common/models/assistant.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';

class ProfileAPI {

  ProfileAPI._();

  static final dio = Dio();
  static final httpBaseUrl = MyConstants.httpDjangoApiBaseUrl;

  static Future<Assistant?> getProfile(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.get('$httpBaseUrl/profile/assistant/');
      if (MyHelpers.resIsOk(res.statusCode)) {
        final assistant = Assistant(
          name: res.data['assistant']['name'] ?? '',
          email: res.data['assistant']['email'] ?? '',
          address: res.data['address'] ?? '',
          phoneNumber: res.data['assistant']['phone_number'] ?? '',
          currentLat: res.data['current_lat'] ?? '',
          currentLng: res.data['current_lng'] ?? '',
          password: '',
          serviceType: res.data['service_type'] ?? '',
          vehicleType: res.data['vehicle_type'] ?? '',
          drivingLicenseCat: res.data['driving_license_cat'] ?? '',
          drivingLicenseNum: res.data['driving_license_num'] ?? '',
          drivingLicenseExpiry: res.data['driving_license_expiry'] ?? '',
          vehicleRegistrationNum: res.data['vehicle_registration_num'] ?? '',
        );
        return assistant;
      }
      return null;
    } catch(ex) {
      print(ex);
      return null;
    }
  }

  static Future<void> updateLocation(double lat, double lng) async {
    try {
      final token = await AuthApi.getAccessToken();
      if (token == null) return;
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post(
        '$httpBaseUrl/profile/update-location/',
        data: {
          'latitude': lat,
          'longitude': lng,
        },
      );
    } catch(ex) {
      print(ex);
    }
  }

}