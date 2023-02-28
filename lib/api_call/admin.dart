import 'package:dio/dio.dart';

import './link_constant.dart';
import '../data/admin.dart';

class AdminApi {
  final Dio _dio = Dio();

  final _baseUrl = '$ADMIN';

  Future<LoginAdminResponse?> login(
      {required LoginAdminRequest loginRequest}) async {
    LoginAdminResponse? result;
    try {
      Response response = await _dio.post(
        _baseUrl + '/login',
        data: loginRequest.toJson(),
      );
      result = LoginAdminResponse.fromJson(response.data);
    } catch (e) {
      print('Error login to admin side: $e');
    }
    return result;
  }
}
