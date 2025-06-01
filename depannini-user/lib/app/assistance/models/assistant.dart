import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

@JsonSerializable()
class Assistant {

  final String name;
  final String phoneNumber;
  final double currentLat;
  final double currentLng;
  final String serviceType;
  final String vehicleType;

  Assistant({
    required this.name,
    required this.phoneNumber,
    required this.currentLat,
    required this.currentLng,
    required this.serviceType,
    required this.vehicleType,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantToJson(this);

}