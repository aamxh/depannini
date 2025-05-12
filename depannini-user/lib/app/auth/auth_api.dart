import 'package:depannini_user/core/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthRepo {

  AuthRepo._();

  static Future<void> signUpUser() async {
    final baseUrl = MyConstants.djangoApiBaseUrl;
    final dio = Dio();
    try {
      final res = await dio.post(baseUrl + "/auth/register/", data: ,);
    } catch(ex) {
      print(ex);
    }

  }

}