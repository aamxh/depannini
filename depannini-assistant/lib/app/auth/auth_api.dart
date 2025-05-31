import 'package:depannini_assistant/app/main/models/assistant.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthApi {

  AuthApi._();

  static Future<bool> signUpUser(Assistant assistant) async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    final assistantMap = MyHelpers.modifySignUpDataFormat(assistant);
    print(assistantMap);
    try {
      final res = await dio.post('$baseUrl/auth/register/',
        data: jsonEncode(assistantMap),);
      print(res);
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

  static Future<bool> signInUserWithPhoneNum(String phoneNum, String password) async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    final payload = {
      'phone_number': phoneNum,
      'password': password,
    };
    print(payload);
    try {
      final res = await dio.post('$baseUrl/auth/login/phone/',
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