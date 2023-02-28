import 'package:dio/dio.dart';

import '../data/all_attendance_list.dart';
import './link_constant.dart';

class AttendanceApi {
  final Dio _dio = Dio();

  final _baseUrl = ATTENDANCE_LIST;

  Future<GetAllEmployeeAttendanceListResponse?>
      getEmployeeAttendanceList() async {
    GetAllEmployeeAttendanceListResponse? result;
    try {
      var response = await _dio.get(_baseUrl + '/all/list');

      if (response != null) {
        result = GetAllEmployeeAttendanceListResponse.fromJson(response.data);
      }
    } catch (e) {
      print('Error get employee list of attandance: $e');
    }
    return result;
  }
}
