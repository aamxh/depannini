import 'dart:async';
import 'package:depannini_assistant/app/assistance/assistance_view_model.dart';
import 'package:depannini_assistant/app/auth/auth_api.dart';
import 'package:depannini_assistant/app/main/assistant_view_model.dart';
import 'package:depannini_assistant/app/main/assistant_ws_view_model.dart';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<bool> changeAssistantState(bool isActive) async {
    final dio = Dio();
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    try {
      final token = await AuthApi.getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.put(
        "$baseUrl/profile/update-status/",
        data: {"is_active": isActive},
      );
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
  }

  static Future<bool> acceptAssistance(String id) async {
    final dio = Dio();
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    try {
      final token = await AuthApi.getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.patch("$baseUrl/assistance/accept/$id/");
      if (MyHelpers.resIsOk(res.statusCode)) {
        Get.find<AssistanceVM>().phoneNum = res.data['client']['phone_number'];
        final res2 = await changeAssistantState(false);
        if (res2) {
          //await closeWSConnection(Get.find<AssistantWSVM>().channel);
          final res3 = await connectToAssistanceWS(Get.find<AssistanceVM>().assistance.id.toString());
          if (res3 != null) {
            Get.find<AssistanceVM>().assistance.state = 'accepted';
            return true;
          }
        }
      }
      return false;
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
  }

  static Future<void> updateAssistanceState(String id, String state) async {
    final dio = Dio();
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    try {
      final token = await AuthApi.getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.patch(
        "$baseUrl/assistance/update/status/$id/",
        data: {"status": state},
      );
      if (MyHelpers.resIsOk(res.statusCode)) {
        //await closeWSConnection(Get.find<AssistanceVM>().channel);
        Get.find<AssistanceVM>().state = state;
      }
    } on Exception catch (ex) {
      print(ex);
    }
  }

  static Future<WebSocketChannel?> connectToAssistantWS(String id) async {
    final baseUrl = MyConstants.wsDjangoApiBaseUrl;
    final url = "$baseUrl/assistant/$id/";
    print("Connecting to: $url");
    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      await channel.ready;
      return channel;
    } on Exception catch(ex) {
      print(ex);
      return null;
    }
  }

  static Future<WebSocketChannel?> connectToAssistanceWS(String id) async {
    final baseUrl = MyConstants.wsDjangoApiBaseUrl;
    final url = "$baseUrl/assistance/$id/";
    print("Connecting to: $url");
    try {
      final channel = WebSocketChannel.connect(Uri.parse(url));
      await channel.ready;
      return channel;
    } on Exception catch(ex) {
      print(ex);
      return null;
    }
  }

  static Future<void> closeWSConnection(WebSocketChannel? channel) async {
    if (channel == null) return;
    try {
      await channel.sink.close();
    } on Exception catch(ex) {
      print(ex);
    }
  }

}