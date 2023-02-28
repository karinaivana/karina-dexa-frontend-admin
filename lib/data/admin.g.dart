// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      json['id'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'username': instance.username,
      'password': instance.password,
    };

LoginAdminResponse _$LoginAdminResponseFromJson(Map<String, dynamic> json) =>
    LoginAdminResponse(
      json['success'] as bool,
      json['message'] as String,
      Admin.fromJson(json['adminDTO'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginAdminResponseToJson(LoginAdminResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'adminDTO': instance.admin,
    };

LoginAdminRequest _$LoginAdminRequestFromJson(Map<String, dynamic> json) =>
    LoginAdminRequest(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginAdminRequestToJson(LoginAdminRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
