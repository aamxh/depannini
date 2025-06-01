import 'package:json_annotation/json_annotation.dart';

part 'assistance_request.g.dart';

@JsonSerializable()
class AssistanceRequest {

  final String assistanceType;
  final String vehicleType;
  final Map<String, double> pickup;
  final Map<String, double> dropoff;
  final String description;

  AssistanceRequest({
    required this.assistanceType,
    required this.vehicleType,
    required this.pickup,
    required this.dropoff,
    required this.description,
  });

  factory AssistanceRequest.fromJson(Map<String, dynamic> json) => _$AssistanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssistanceRequestToJson(this);

}