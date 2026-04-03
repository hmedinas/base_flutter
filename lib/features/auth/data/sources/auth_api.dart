import 'dart:convert';

import 'package:base_flutter/core/api/api_client.dart';
import 'package:base_flutter/core/common/domain/entities/user_models.dart';
import 'package:base_flutter/features/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  final ApiClient _api = ApiClient();

  Future<LoginResponseModel> login(String userName, String password) async {
    try {
      // Sintaxis idéntica a Axios
      final response = await _api.dio.post(
        '/login',
        data: {'UserName': userName, 'Password': password},
      );

      return LoginResponseModel.fromApi(response.data, userName, password);

    } on DioException catch (e) {
      // Manejo de errores estilo Axios
      final msg = e.response?.data['message'] ?? 'Error de conexión';
      return LoginResponseModel(statusCode: 400, message: msg);
    }
  }
}
