import 'package:depannini_assistant/app/main/models/assistant.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (MyHelpers.resIsOk(res.statusCode)) {
        await saveAccessToken(
          res.data['tokens']['access'],
          res.data['tokens']['refresh'],
          DateTime.now().add(const Duration(days: 7)),
        );
        return true;
      }
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
      if (MyHelpers.resIsOk(res.statusCode)) {
        await saveAccessToken(
          res.data['tokens']['access'],
          res.data['tokens']['refresh'],
          DateTime.now().add(const Duration(days: 7)),
        );
        return true;
      }
      return false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }


  static Future<void> saveAccessToken(
      String accessToken,
      String refreshToken,
      DateTime expiryDate,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString('token_expiry', expiryDate.toIso8601String());
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<bool> isTokenValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final expiry = prefs.getString('token_expiry');
      if (token == null || expiry == null) return false;
      final expiryDate = DateTime.tryParse(expiry);
      if (expiryDate == null) return false;
      return DateTime.now().isBefore(expiryDate.subtract(const Duration(minutes: 1)));
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> tryRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    if (refreshToken == null) return false;
    final baseUrl = MyConstants.djangoApiBaseUrl;
    try {
      final response = await Dio().post(
        "$baseUrl/auth/token/refresh/",
        data: {'token': refreshToken},
      );
      final newAccessToken = response.data['access_token'];
      final newExpiry = DateTime.now().add(const Duration(days: 7));
      await prefs.setString('access_token', newAccessToken);
      await prefs.setString('token_expiry', newExpiry.toIso8601String());
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> isUserAuthenticated() async {
    if (await isTokenValid()) return true;
    return await tryRefreshToken();
  }

}