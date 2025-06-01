import 'package:depannini_user/app/assistance/models/assistant.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceVM extends GetxController {

  final Rx<int> _id = 0.obs;
  final Rx<String> _state = 'requested'.obs;
  final Rx<Assistant?> _assistant = null.obs;
  final Rx<WebSocketChannel?> _channel = null.obs;

  int get id => _id.value;
  String get state => _state.value;
  Assistant? get assistant => _assistant.value;
  WebSocketChannel? get channel => _channel.value;

  set id(int val) => _id.value = val;
  set state(String val) => _state.value = val;
  set assistant(Assistant? val) => _assistant.value = val;
  set channel(WebSocketChannel? val) => _channel.value = val;

}