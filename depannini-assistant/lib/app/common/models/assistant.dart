import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

@JsonSerializable()
class Assistant {

  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final double currentLat;
  final double currentLng;
  final String address;
  final String serviceType;
  final String vehicleType;
  final String drivingLicenseCat;
  final String drivingLicenseNum;
  final String drivingLicenseExpiry;
  final int vehicleRegistrationNum;

  Assistant({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.currentLat,
    required this.currentLng,
    required this.address,
    required this.serviceType,
    required this.vehicleType,
    required this.drivingLicenseCat,
    required this.drivingLicenseNum,
    required this.drivingLicenseExpiry,
    required this.vehicleRegistrationNum,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) => _$AssistantFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantToJson(this);

}