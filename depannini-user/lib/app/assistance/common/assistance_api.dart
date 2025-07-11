import 'package:depannini_user/app/assistance/view_models/assistance_view_model.dart';
import 'package:depannini_user/app/assistance/models/assistance_request.dart';
import 'package:depannini_user/app/auth/common/auth_api.dart';
import 'package:depannini_user/core/constants.dart';
import 'package:depannini_user/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceAPI {

  AssistanceAPI._();

  static final dio = Dio();
  static final httpBaseUrl = MyConstants.httpDjangoApiBaseUrl;
  static final wsBaseUrl = MyConstants.wsDjangoApiBaseUrl;

  static Future<WebSocketChannel?> requestAssistance(AssistanceRequest assistance) async {
    try {
    final token = await AuthApi.getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $token';
    Map<String, dynamic> payload = assistance.toJson();
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'assistanceType');
    payload = MyHelpers.modifyCamelToSnakeForOneKey(payload, 'vehicleType');
    print(payload.toString());
    final res = await dio.post('$httpBaseUrl/assistance/request/',
      data: jsonEncode(payload),);
    print(res.toString());
    if (MyHelpers.resIsOk(res.statusCode)) {
      final channel = await connectToAssistanceWS(res.data['assistance']['id'].toString());
      if (channel != null) {
        Get.put(AssistanceVM());
        Get.find<AssistanceVM>().id = res.data['assistance']['id'];
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
    final url = "$wsBaseUrl/assistance/$id/";
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
    try {
      final token = await AuthApi.getAccessToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final res = await dio.patch(
        "$httpBaseUrl/assistance/update/status/$id/",
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