// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_attendance_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceList _$AttendanceListFromJson(Map<String, dynamic> json) =>
    AttendanceList(
      json['id'] as int,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['employeeId'] as int,
      json['startWorkAt'] == null
          ? null
          : DateTime.parse(json['startWorkAt'] as String),
      json['endWorkAt'] == null
          ? null
          : DateTime.parse(json['endWorkAt'] as String),
    );

Map<String, dynamic> _$AttendanceListToJson(AttendanceList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'employeeId': instance.employeeId,
      'startWorkAt': instance.startWorkAt?.toIso8601String(),
      'endWorkAt': instance.endWorkAt?.toIso8601String(),
    };

GetAllEmployeeAttendanceListResponse
    _$GetAllEmployeeAttendanceListResponseFromJson(Map<String, dynamic> json) =>
        GetAllEmployeeAttendanceListResponse(
          json['success'] as bool,
          (json['attendanceListDTOS'] as List<dynamic>)
              .map((e) => AttendanceList.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAllEmployeeAttendanceListResponseToJson(
        GetAllEmployeeAttendanceListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'attendanceListDTOS': instance.attendanceListDTOS,
    };
