import 'dart:convert';
import 'package:depannini_assistant/app/common/location_api.dart';
import 'package:depannini_assistant/app/assistance/models/assistance.dart';
import 'package:depannini_assistant/app/assistance/models/client.dart';
import 'package:depannini_assistant/app/assistance/common/notifications_api.dart';
import 'package:depannini_assistant/app/assistance/view_models/assistance_view_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AssistantWSVM extends GetxController {

  final Rx<WebSocketChannel?> _channel = Rx<WebSocketChannel?>(null);
  final Rx<String> _id = ''.obs;

  set channel(WebSocketChannel? val) => _channel.value = val;
  set id(String val) => _id.value = val;

  WebSocketChannel? get channel => _channel.value;
  String get id => _id.value;

  Future<void> startListening() async {
    if (channel != null) {
      channel!.stream.listen((event) async {
        final data = jsonDecode(event);
        print("Received data in VM: $data");
        if (data['type'] == 'new_assistance_request') {
          final description = data['assistance_type'] == 'repair' ? data['description'] : '';
          final toLat = data['assistance_type'] == 'towing' ? data['dropoff_location']['lat'] : 0.0;
          final toLng = data['assistance_type'] == 'towing' ? data['dropoff_location']['lng'] : 0.0;
          final fromAddress = await LocationApi.getLocationDescription(LatLng(
            data['pickup_location']['lat'],
            data['pickup_location']['lng'],
          )) ?? '';
          final toAddress = data['assistance_type'] == 'towing' ?
          await LocationApi.getLocationDescription(LatLng(
            data['dropoff_location']['lat'],
            data['dropoff_location']['lng'],
          )) ?? '' : '';
          final assistanceVM = Get.find<AssistanceVM>();
          assistanceVM.assistance = Assistance(
            id: data["assistance_id"],
            state: 'requested',
            client: Client(
              address: fromAddress,
              name: data['client']['name'],
              phoneNum: '',
              lat: data['pickup_location']['lat'],
              lng: data['pickup_location']['lng'],
            ),
            type: data['assistance_type'],
            description: description,
            vehicleType: data['vehicle_type'],
            toLat: toLat,
            toLng: toLng,
            toAddress: toAddress,
          );
          final res =
          await NotificationsApi.verifyNotificationsEnabled();
          if (res) {
            await NotificationsApi.sendNotification(
              'Incoming assistance request.',
              'Click to see more..',
              payload: data['assistance_type'],
            );
          }
        }
      },
          onDone: () {
            print('Assistant ws closed.');
          },
          onError: (ex) {
            print(ex);
          }
      );
    }
  }

}