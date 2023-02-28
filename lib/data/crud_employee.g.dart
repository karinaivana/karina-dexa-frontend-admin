// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crud_employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      json['id'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['name'] as String,
      json['email'] as String,
      json['password'] as String,
      json['role'] as String,
      json['phoneNumber'] as String,
      json['photoLink'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'photoLink': instance.photoLink,
    };

GetAllEmployeeDataResponse _$GetAllEmployeeDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllEmployeeDataResponse(
      json['success'] as bool,
      (json['employeeDTOList'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllEmployeeDataResponseToJson(
        GetAllEmployeeDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'employeeDTOList': instance.employeeList,
    };

CreateOrUpdateEmployeeByAdminRequest
    _$CreateOrUpdateEmployeeByAdminRequestFromJson(Map<String, dynamic> json) =>
        CreateOrUpdateEmployeeByAdminRequest(
          json['id'] as int?,
          json['name'] as String,
          json['email'] as String,
          json['password'] as String,
          json['role'] as String,
          json['phoneNumber'] as String,
          json['photoLink'] as String,
        );

Map<String, dynamic> _$CreateOrUpdateEmployeeByAdminRequestToJson(
        CreateOrUpdateEmployeeByAdminRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'photoLink': instance.photoLink,
    };

CreateOrUpdateEmployeeByAdminResponse
    _$CreateOrUpdateEmployeeByAdminResponseFromJson(
            Map<String, dynamic> json) =>
        CreateOrUpdateEmployeeByAdminResponse(
          json['success'] as bool,
          json['message'] as String,
          Employee.fromJson(json['employeeDTO'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$CreateOrUpdateEmployeeByAdminResponseToJson(
        CreateOrUpdateEmployeeByAdminResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'employeeDTO': instance.employee,
    };