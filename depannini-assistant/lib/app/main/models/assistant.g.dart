// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assistant _$AssistantFromJson(Map<String, dynamic> json) => Assistant(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNum: json['phoneNum'] as String,
      currentLat: (json['currentLat'] as num).toDouble(),
      currentLng: (json['currentLng'] as num).toDouble(),
      serviceType: json['serviceType'] as String,
      vehicleType: json['vehicleType'] as String,
      drivingLicenseCat: json['drivingLicenseCat'] as String,
      drivingLicenseNum: json['drivingLicenseNum'] as String,
      drivingLicenseExpiry: json['drivingLicenseExpiry'] as String,
      vehicleRegistrationNumber:
          (json['vehicleRegistrationNumber'] as num).toInt(),
    );

Map<String, dynamic> _$AssistantToJson(Assistant instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phoneNum': instance.phoneNum,
      'currentLat': instance.currentLat,
      'currentLng': instance.currentLng,
      'serviceType': instance.serviceType,
      'vehicleType': instance.vehicleType,
      'drivingLicenseCat': instance.drivingLicenseCat,
      'drivingLicenseNum': instance.drivingLicenseNum,
      'drivingLicenseExpiry': instance.drivingLicenseExpiry,
      'vehicleRegistrationNumber': instance.vehicleRegistrationNumber,
    };
