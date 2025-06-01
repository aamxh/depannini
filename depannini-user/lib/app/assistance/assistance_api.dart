import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/app/auth/auth_api.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<bool> requestAssistance(AssistanceRequest assistance) async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    final token = await AuthApi.getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    Map<String, dynamic> payload = assistance.toJson();
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'assistanceType');
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'vehicleType');
    print(payload);
    try {
      final res = await dio.post('$baseUrl/assistance/request/',
        data: jsonEncode(payload),);
      print(res);
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

}