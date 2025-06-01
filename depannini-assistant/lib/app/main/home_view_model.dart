import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';

class HomeVM extends GetxController {

  final RxBool _isActive = false.obs;
  final Rx<WebSocketChannel?> _channel = null.obs;

  bool get isActive => _isActive.value;
  WebSocketChannel? get channel => _channel.value;

  set isActive(bool val) => _isActive.value;
  set channel(WebSocketChannel? val) => _channel.value;

}