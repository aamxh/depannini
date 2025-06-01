// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assistant _$AssistantFromJson(Map<String, dynamic> json) => Assistant(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      currentLat: (json['currentLat'] as num).toDouble(),
      currentLng: (json['currentLng'] as num).toDouble(),
      serviceType: json['serviceType'] as String,
      vehicleType: json['vehicleType'] as String,
    );

Map<String, dynamic> _$AssistantToJson(Assistant instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'currentLat': instance.currentLat,
      'currentLng': instance.currentLng,
      'serviceType': instance.serviceType,
      'vehicleType': instance.vehicleType,
    };
