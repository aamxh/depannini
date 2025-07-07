import 'package:depannini_assistant/app/main/view_models/assistant_ws_view_model.dart';
import 'package:depannini_assistant/app/common/models/assistant.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {

  AuthApi._();

  static final dio = Dio();
  static final httpBaseUrl = MyConstants.httpDjangoApiBaseUrl;

  static Future<bool> signUpUser(Assistant assistant) async {
    final assistantMap = MyHelpers.modifySignUpDataFormat(assistant);
    try {
      final res = await dio.post('$httpBaseUrl/auth/register/',
        data: jsonEncode(assistantMap),);
      if (MyHelpers.resIsOk(res.statusCode)) {
        await saveAccessToken(
          res.data['tokens']['access'],
          res.data['tokens']['refresh'],
          DateTime.now().add(const Duration(days: 7)),
        );
        Get.put(AssistantWSVM(), permanent: true);
        Get.find<AssistantWSVM>().id = res.data['user']['id'].toString();
        return true;
      }
      return false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

  static Future<bool> signInUserWithPhoneNum(String phoneNum, String password) async {
    final payload = {
      'phone_number': phoneNum,
      'password': password,
    };
    try {
      final res = await dio.post('$httpBaseUrl/auth/login/phone/',
        data: jsonEncode(payload),);
      if (MyHelpers.resIsOk(res.statusCode)) {
        await saveAccessToken(
          res.data['tokens']['access'],
          res.data['tokens']['refresh'],
          DateTime.now().add(const Duration(days: 7)),
        );
        Get.put(AssistantWSVM(), permanent: true);
        Get.find<AssistantWSVM>().id = res.data['user']['id'].toString();
        return true;
      }
      return false;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

  static Future<bool> signInUserWithEmail(String email, String password) async {
    final payload = {
      'email': email,
      'password': password,
    };
    try {
      final res = await dio.post('$httpBaseUrl/auth/login/email/',
        data: jsonEncode(payload),);
      if (MyHelpers.resIsOk(res.statusCode)) {
        await saveAccessToken(
          res.data['tokens']['access'],
          res.data['tokens']['refresh'],
          DateTime.now().add(const Duration(days: 7)),
        );
        Get.put(AssistantWSVM(), permanent: true);
        Get.find<AssistantWSVM>().id = res.data['user']['id'].toString();
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
    try {
      final response = await dio.post(
        "$httpBaseUrl/auth/token/refresh/",
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

  static Future<bool> signOut() async {
    bool res = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      await prefs.remove('token_expiry');
      return res;
    } catch(ex) {
      print(ex);
      return false;
    }
  }

}