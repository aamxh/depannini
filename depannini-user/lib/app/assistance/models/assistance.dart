import 'package:json_annotation/json_annotation.dart';
import 'assistant.dart';

part 'assistance.g.dart';

@JsonSerializable()
class Assistance {

  final int id;
  final String state;
  final Assistant assistant;
  final double price;

  Assistance({
    required this.id,
    required this.state,
    required this.assistant,
    required this.price,
  });

  factory Assistance.fromJson(Map<String, dynamic> json) => _$AssistanceFromJson(json);

  Map<String, dynamic> toJson() => _$AssistanceToJson(this);

}