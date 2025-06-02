// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assistance _$AssistanceFromJson(Map<String, dynamic> json) => Assistance(
      id: (json['id'] as num).toInt(),
      state: json['state'] as String,
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      type: json['type'] as String,
      description: json['description'] as String,
      vehicleType: json['vehicleType'] as String,
      toLat: (json['toLat'] as num).toDouble(),
      toLng: (json['toLng'] as num).toDouble(),
      toAddress: json['toAddress'] as String,
    );

Map<String, dynamic> _$AssistanceToJson(Assistance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'client': instance.client,
      'type': instance.type,
      'description': instance.description,
      'vehicleType': instance.vehicleType,
      'toLat': instance.toLat,
      'toLng': instance.toLng,
      'toAddress': instance.toAddress,
    };
