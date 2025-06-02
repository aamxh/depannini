import 'package:depannini_user/app/main/models/client.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {

  AuthApi._();

  static Future<bool> signUpUser(Client client) async {
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
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
      print(res.data['tokens']['access']);
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
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
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

  static Future<bool> signInUserWithEmail(String email, String password) async {
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    final dio = Dio();
    final payload = {
      'email': email,
      'password': password,
    };
    print(payload);
    try {
      final res = await dio.post('$baseUrl/auth/login/email/',
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
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
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