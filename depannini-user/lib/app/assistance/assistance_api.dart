import 'package:depannini_user/app/assistance/assistance_view_model.dart';
import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/app/auth/auth_api.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<WebSocketChannel?> requestAssistance(AssistanceRequest assistance) async {
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    final dio = Dio();
    try {
    final token = await AuthApi.getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    Map<String, dynamic> payload = assistance.toJson();
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'assistanceType');
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'vehicleType');
    print(payload);
    final res = await dio.post('$baseUrl/assistance/request/',
      data: jsonEncode(payload),);
    print(res);
    if (MyHelpers.resIsOk(res.statusCode)) {
      final channel = await connectToAssistanceWS(res.data['id']);
      if (channel != null) {
        Get.put(AssistanceVM());
        Get.find<AssistanceVM>().id = res.data['id'];
      }
      return channel;
    }
    return null;
    } catch(ex) {
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

  static Future<bool> updateAssistanceState(String id, String state) async {
    final dio = Dio();
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    try {
      final token = await AuthApi.getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.patch(
        "$baseUrl/assistance/update/status/$id/",
        data: {"status": state},
      );
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } on Exception catch (ex) {
      print(ex);
      return false;
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