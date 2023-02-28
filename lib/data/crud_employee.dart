import 'package:json_annotation/json_annotation.dart';

part 'crud_employee.g.dart';

@JsonSerializable()
class Employee {
  final int id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String name;
  final String email;
  final String password;
  @JsonKey(name: "roleDTO")
  final Role role;
  final String phoneNumber;
  final String? photoLink;

  Employee(this.id, this.createdAt, this.updatedAt, this.deletedAt, this.name,
      this.email, this.password, this.role, this.phoneNumber, this.photoLink);

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class Role {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String description;

  Role(this.id, this.createdAt, this.updatedAt, this.deletedAt,
      this.description);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable()
class GetAllEmployeeDataResponse {
  final bool success;
  @JsonKey(name: "employeeDTOList")
  final List<Employee> employeeList;

  GetAllEmployeeDataResponse(this.success, this.employeeList);

  factory GetAllEmployeeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllEmployeeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllEmployeeDataResponseToJson(this);
}

@JsonSerializable()
class CreateOrUpdateEmployeeByAdminRequest {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String phoneNumber;
  final String photoLink;

  CreateOrUpdateEmployeeByAdminRequest(this.id, this.name, this.email,
      this.password, this.role, this.phoneNumber, this.photoLink);

  factory CreateOrUpdateEmployeeByAdminRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CreateOrUpdateEmployeeByAdminRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateOrUpdateEmployeeByAdminRequestToJson(this);
}

@JsonSerializable()
class CreateOrUpdateEmployeeByAdminResponse {
  final bool success;
  final String message;
  @JsonKey(name: "employeeDTO")
  final Employee employee;

  CreateOrUpdateEmployeeByAdminResponse(
      this.success, this.message, this.employee);

  factory CreateOrUpdateEmployeeByAdminResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateOrUpdateEmployeeByAdminResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateOrUpdateEmployeeByAdminResponseToJson(this);
}

@JsonSerializable()
class GetAllRoleResponse {
  final bool success;
  @JsonKey(name: "roleDTOS")
  final List<Role> roleDTOS;

  GetAllRoleResponse(this.success, this.roleDTOS);

  factory GetAllRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllRoleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllRoleResponseToJson(this);
}
