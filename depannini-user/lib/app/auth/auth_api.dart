import 'package:depannini_user/app/main/models/client.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthApi {

  AuthApi._();

  static Future<bool> signUpUser(Client client) async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    final clientMap = client.toJson();
    clientMap.addAll({
      'password_confirm': clientMap['password'],
      'user_type': "client"
    });
    clientMap.remove('email');
    clientMap.remove('location');
    final String num = clientMap['phoneNum'];
    clientMap.remove('phoneNum');
    clientMap['phone_number'] = num;
    print(clientMap);
    try {
      final res = await dio.post('$baseUrl/auth/register/',
        data: jsonEncode(clientMap),);
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