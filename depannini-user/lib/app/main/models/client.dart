import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {

  final String name;
  final String email;
  final String password;
  final String phoneNum;

  Client({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNum,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

}