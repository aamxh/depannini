import 'package:flutter/material.dart';

class MyConstants {

  MyConstants._();

  static final primaryC = Color(0xffd70005);
  static final lightGrey = Colors.grey[200];
  static final mediumGrey = Colors.grey[600];
  static final darkGrey = Colors.grey[800];

  static const reverseGeoCodingApiBaseUrl =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=";

  static const djangoApiBaseUrl = 'http://10.0.2.2:8000/api';

}