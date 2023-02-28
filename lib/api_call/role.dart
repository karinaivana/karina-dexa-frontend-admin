import 'package:dio/dio.dart';
import 'package:employee_app/data/crud_employee.dart';
import './link_constant.dart';

class RoleApi {
  final Dio _dio = Dio();

  final _baseUrl = ROLE;

  Future<GetAllRoleResponse?> getAllRoleList() async {
    GetAllRoleResponse? result;
    try {
      var response = await _dio.get(_baseUrl + '/get/all');

      if (response != null) {
        result = GetAllRoleResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error get employee list of attandance: $e');
    }
    return result;
  }
}
