import 'package:json_annotation/json_annotation.dart';

part 'admin.g.dart';

@JsonSerializable()
class Admin {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String username;
  final String password;

  Admin(this.id, this.createdAt, this.updatedAt, this.deletedAt, this.username,
      this.password);

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  Map<String, dynamic> toJson() => _$AdminToJson(this);
}

@JsonSerializable()
class LoginAdminResponse {
  final bool success;
  final String message;
  @JsonKey(name: "adminDTO")
  final Admin admin;

  LoginAdminResponse(this.success, this.message, this.admin);

  factory LoginAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginAdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAdminResponseToJson(this);
}

@JsonSerializable()
class LoginAdminRequest {
  final String username;
  final String password;

  LoginAdminRequest(this.username, this.password);

  factory LoginAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginAdminRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginAdminRequestToJson(this);
}
