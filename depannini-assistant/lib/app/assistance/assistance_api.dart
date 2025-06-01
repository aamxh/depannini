import 'dart:async';
import 'package:depannini_assistant/core/constants.dart';
import 'package:depannini_assistant/core/helpers.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceAPI {

  AssistanceAPI._();

  static Future<bool> changeAssistantState(bool isActive) async {
    final dio = Dio();
    final baseUrl = MyConstants.httpDjangoApiBaseUrl;
    try {
      final res = await dio.post(
        "$baseUrl/profile/assistant-status/",
        data: {"is_active": isActive},
      );
      if (MyHelpers.resIsOk(res.statusCode)) return true;
      return false;
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
  }

  static Future<WebSocketChannel?> connectToWS(String id) async {
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

  static Future<void> closeWSConnection(WebSocketChannel? channel) async {
    if (channel == null) return;
    try {
      await channel.sink.close();
    } on Exception catch(ex) {
      print(ex);
    }
  }

}