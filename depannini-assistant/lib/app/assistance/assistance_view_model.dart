import 'dart:convert';
import 'package:depannini_assistant/app/assistance/location_view_model.dart';
import 'package:depannini_assistant/app/assistance/models/assistance.dart';
import 'package:depannini_assistant/app/assistance/models/client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistanceVM extends GetxController {

  final Rx<Assistance> _assistance = Assistance(
    toAddress: '',
    toLat: 0.0,
    toLng: 0.0,
    vehicleType: '',
    state: '',
    type: '',
    description: '',
    id: 0,
    client: Client(
      address: '',
      name: '',
      phoneNum: '',
      lat: 0.0,
      lng: 0.0,
    ),
  ).obs;
  final Rx<WebSocketChannel?> _channel = Rx<WebSocketChannel?>(null);
  final Rx<String> _state = 'requested'.obs;

  WebSocketChannel? get channel => _channel.value;
  Assistance get assistance => _assistance.value;
  String get state => _state.value;

  set assistance(Assistance val) => _assistance.value = val;
  set channel(WebSocketChannel? val) => _channel.value = val;
  set state(String val) => _state.value = val;
  set phoneNum(String val) => _assistance.value.client.phoneNum = val;

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
        } else if (data['type'] == 'status') {
          state = data['status'];
          print(state);
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