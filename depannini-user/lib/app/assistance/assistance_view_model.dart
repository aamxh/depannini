import 'dart:convert';
import 'package:depannini_user/app/assistance/location_view.dart';
import 'package:depannini_user/app/assistance/location_view_model.dart';
import 'package:depannini_user/app/assistance/models/assistant.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceVM extends GetxController {

  final Rx<int> _id = 0.obs;
  final Rx<String> _state = 'requested'.obs;
  final Rx<Assistant?> _assistant = null.obs;
  final Rx<WebSocketChannel?> _channel = null.obs;
  final Rx<bool> _arrived = false.obs;

  int get id => _id.value;
  String get state => _state.value;
  Assistant? get assistant => _assistant.value;
  WebSocketChannel? get channel => _channel.value;
  bool get arrived => _arrived.value;

  set id(int val) => _id.value = val;
  set state(String val) => _state.value = val;
  set assistant(Assistant? val) => _assistant.value = val;
  set channel(WebSocketChannel? val) => _channel.value = val;
  set arrived(bool val) => _arrived.value = val;

  void startListening() {
    if (channel != null) {
      channel!.stream.listen((event) {
        final data = jsonDecode(event);
        print("Received data in VM: $data");
        if (data['type'] == 'location') {
          Get.find<LocationVM>().assistantLocation = LatLng(
            double.parse(data['lat']),
            double.parse(data['lng']),
          );
        } else {
          if (data['status'] == 'accepted') {
            Get.put(LocationVM());
            Get.to(() => LocationV());
          }
        }
      },
          onDone: () {
            print('Assistance ws closed.');
          },
          onError: (ex) {
            print(ex);
          }
      );
    }
  }

}