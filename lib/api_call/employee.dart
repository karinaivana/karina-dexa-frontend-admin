import 'package:dio/dio.dart';
import 'package:employee_app/data/crud_employee.dart';
import './link_constant.dart';

class EmployeeApi {
  final Dio _dio = Dio();

  final _baseUrl = EMPLOYEE;

  Future<GetAllEmployeeDataResponse?> getAllEmployeeData() async {
    GetAllEmployeeDataResponse? result;
    try {
      var response = await _dio.get(_baseUrl + '/all/list');

      if (response != null) {
        result = GetAllEmployeeDataResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error get all employee data: $e');
    }
    return result;
  }

  Future<CreateOrUpdateEmployeeByAdminResponse?> createOrUpdateEmployee(
      {required CreateOrUpdateEmployeeByAdminRequest
          createOrUpdateEmployeeByAdminRequest}) async {
    CreateOrUpdateEmployeeByAdminResponse? result;
    try {
      Response response = await _dio.post(
        _baseUrl + '/create-or-update',
        data: createOrUpdateEmployeeByAdminRequest.toJson(),
      );
      result = CreateOrUpdateEmployeeByAdminResponse.fromJson(response.data);
    } catch (e) {
      print('Error create or update employee data: $e');
    }
    return result;
  }
}
