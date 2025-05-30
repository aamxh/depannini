import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'lat_lng_converter.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {

  final String name;
  final String email;
  final String password;
  final String phoneNum;

  @LatLngConverter()
  final LatLng location;

  Client({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNum,
    required this.location,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

}