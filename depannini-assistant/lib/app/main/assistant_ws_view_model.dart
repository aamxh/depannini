import 'dart:convert';
import 'package:depannini_assistant/app/assistance/location_api.dart';
import 'package:depannini_assistant/app/assistance/models/assistance.dart';
import 'package:depannini_assistant/app/assistance/models/client.dart';
import 'package:depannini_assistant/app/assistance/notifications_api.dart';
import 'package:depannini_assistant/app/assistance/assistance_view_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeVM extends GetxController {

  final Rx<WebSocketChannel?> _channel = null.obs;

  set channel(WebSocketChannel? val) => _channel.value = val;

  WebSocketChannel? get channel => _channel.value;

  Future<void> startListening() async {
    if (channel != null) {
      channel!.stream.listen((event) async {
        final data = jsonDecode(event);
        print("Received data in VM: $data");
        final description = data['type'] == 'repair' ? data['description'] : '';
        final toLat = data['type'] == 'towing' ? data['dropoff_location']['lat'] : '';
        final toLng = data['type'] == 'towing' ? data['dropoff_location']['lng'] : '';
        final fromAddress = await LocationApi.getLocationDescription(LatLng(
          double.parse(data['pickup_location']['lat']),
          double.parse(data['pickup_location']['lng']),
        )) ?? '';
        final toAddress = data['type'] == 'towing' ?
        await LocationApi.getLocationDescription(LatLng(
          double.parse(data['dropoff_location']['lat']),
          double.parse(data['dropoff_location']['lng']),
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
          type: data[''],
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