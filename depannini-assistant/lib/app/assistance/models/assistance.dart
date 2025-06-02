import 'package:json_annotation/json_annotation.dart';
import 'client.dart';

part 'assistance.g.dart';

@JsonSerializable()
class Assistance {

  final int id;
  final String state;
  final Client client;
  final String type;
  final String description;
  final String vehicleType;
  final double toLat;
  final double toLng;
  final String toAddress;

  Assistance({
    required this.id,
    required this.state,
    required this.client,
    required this.type,
    required this.description,
    required this.vehicleType,
    required this.toLat,
    required this.toLng,
    required this.toAddress,
  });

  factory Assistance.fromJson(Map<String, dynamic> json) => _$AssistanceFromJson(json);

  Map<String, dynamic> toJson() => _$AssistanceToJson(this);

}