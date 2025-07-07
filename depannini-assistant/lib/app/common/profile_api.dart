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
          address: res.data['assistant']['address'] ?? '',
          phoneNumber: res.data['assistant']['phone_number'] ?? '',
          currentLat: res.data['assistant']['current_lat'] ?? 0.0,
          currentLng: res.data['assistant']['current_lng'] ?? 0.0,
          password: '',
          serviceType: res.data['assistant']['service_type'] ?? '',
          vehicleType: res.data['assistant']['vehicle_type'] ?? '',
          drivingLicenseCat: res.data['assistant']['driving_license_cat'] ?? '',
          drivingLicenseNum: res.data['assistant']['driving_license_num'] ?? '',
          drivingLicenseExpiry: res.data['assistant']['driving_license_expiry'] ?? '',
          vehicleRegistrationNum: res.data['assistant']['vehicle_registration_num'] ?? 0,
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