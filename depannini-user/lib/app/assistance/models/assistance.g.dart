// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assistance _$AssistanceFromJson(Map<String, dynamic> json) => Assistance(
      id: (json['id'] as num).toInt(),
      state: json['state'] as String,
      assistant: Assistant.fromJson(json['assistant'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$AssistanceToJson(Assistance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'assistant': instance.assistant,
      'price': instance.price,
    };
