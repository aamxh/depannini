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
      'address': null,
      'password_confirm': null,
      'user_type': client
    });
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

}