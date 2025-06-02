import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {

  final String name;
  String phoneNum = '';
  final double lat;
  final double lng;
  final String address;

  Client({
    required this.name,
    required this.phoneNum,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

}