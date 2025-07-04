// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assistant _$AssistantFromJson(Map<String, dynamic> json) => Assistant(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      currentLat: (json['currentLat'] as num).toDouble(),
      currentLng: (json['currentLng'] as num).toDouble(),
      serviceType: json['serviceType'] as String,
      vehicleType: json['vehicleType'] as String,
      drivingLicenseCat: json['drivingLicenseCat'] as String,
      drivingLicenseNum: json['drivingLicenseNum'] as String,
      drivingLicenseExpiry: json['drivingLicenseExpiry'] as String,
      vehicleRegistrationNum: (json['vehicleRegistrationNum'] as num).toInt(),
    );

Map<String, dynamic> _$AssistantToJson(Assistant instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'currentLat': instance.currentLat,
      'currentLng': instance.currentLng,
      'serviceType': instance.serviceType,
      'vehicleType': instance.vehicleType,
      'drivingLicenseCat': instance.drivingLicenseCat,
      'drivingLicenseNum': instance.drivingLicenseNum,
      'drivingLicenseExpiry': instance.drivingLicenseExpiry,
      'vehicleRegistrationNum': instance.vehicleRegistrationNum,
    };
