import 'package:flutter/material.dart';

class MyConstants {

  MyConstants._();

  static final primaryC = Color(0xffd70005);
  static final lightGrey = Colors.grey[200];
  static final mediumGrey = Colors.grey[600];
  static final darkGrey = Colors.grey[800];

  static const reverseGeoCodingApiBaseUrl =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=";

  static const directionsApiBaseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?origin=";

  static const httpDjangoApiBaseUrl = 'http://192.168.6.191:8000/api';

  static const wsDjangoApiBaseUrl = 'ws://192.168.6.191:8000/ws';

}