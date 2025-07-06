import 'package:depannini_user/app/auth/common/auth_api.dart';
import 'package:depannini_user/app/common/models/client.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';

class ProfileAPI {

  ProfileAPI._();

  static final dio = Dio();
  static final httpBaseUrl = MyConstants.httpDjangoApiBaseUrl;

  static Future<Client?> getProfile(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.get('$httpBaseUrl/profile/user/');
      if (MyHelpers.resIsOk(res.statusCode)) {
        final assistant = Client(
          name: res.data['user']['name'] ?? '',
          email: res.data['user']['email'] ?? '',
          address: res.data['address'] ?? '',
          phoneNum: res.data['user']['phone_number'] ?? '',
          currentLat: res.data['current_lat'] ?? '',
          currentLng: res.data['current_lng'] ?? '',
          password: '',
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