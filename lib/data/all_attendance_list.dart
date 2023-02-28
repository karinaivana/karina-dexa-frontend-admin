import 'package:json_annotation/json_annotation.dart';

part 'all_attendance_list.g.dart';

@JsonSerializable()
class AttendanceList {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int employeeId;
  final DateTime? startWorkAt;
  final DateTime? endWorkAt;

  AttendanceList(this.id, this.createdAt, this.updatedAt, this.deletedAt,
      this.employeeId, this.startWorkAt, this.endWorkAt);

  factory AttendanceList.fromJson(Map<String, dynamic> json) =>
      _$AttendanceListFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceListToJson(this);
}

@JsonSerializable()
class GetAllEmployeeAttendanceListResponse {
  final bool success;
  final List<AttendanceList> attendanceListDTOS;

  GetAllEmployeeAttendanceListResponse(this.success, this.attendanceListDTOS);

  factory GetAllEmployeeAttendanceListResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetAllEmployeeAttendanceListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetAllEmployeeAttendanceListResponseToJson(this);
}
