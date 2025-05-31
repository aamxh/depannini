import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<bool> requestAssistance(AssistanceRequest assistance) async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5MzE3NTE3LCJpYXQiOjE3NDg3MTI3MTcsImp0aSI6ImZhODMxODcwMTk1MzQ4MzM4Y2EyMGNmMWYwZTlkNGE5IiwidXNlcl9pZCI6NDN9.ZOVvB0GNArBZAHDeQmpiaEx7FYWZ9hPzcngM0bHkkmk';
    Map<String, dynamic> payload = assistance.toJson();
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'assistanceType');
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'vehicleType');
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'dropOff');
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