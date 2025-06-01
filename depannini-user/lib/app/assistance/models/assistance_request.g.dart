// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistanceRequest _$AssistanceRequestFromJson(Map<String, dynamic> json) =>
    AssistanceRequest(
      assistanceType: json['assistanceType'] as String,
      vehicleType: json['vehicleType'] as String,
      pickup: (json['pickup'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      dropoff: (json['dropoff'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      description: json['description'] as String,
    );

Map<String, dynamic> _$AssistanceRequestToJson(AssistanceRequest instance) =>
    <String, dynamic>{
      'assistanceType': instance.assistanceType,
      'vehicleType': instance.vehicleType,
      'pickup': instance.pickup,
      'dropoff': instance.dropoff,
      'description': instance.description,
    };
