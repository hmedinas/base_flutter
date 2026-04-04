import 'package:hm_flutter_base/core/api/api_client.dart';
import 'package:hm_flutter_base/core/constants/app_end_point.dart';
import 'package:hm_flutter_base/core/utils/console.dart';
import 'package:hm_flutter_base/features/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';

class AuthApi {
  final ApiClient _api = ApiClient();

  Future<LoginResponseModel> login(String userName, String password) async {
    try {
      // Sintaxis idéntica a Axios
      final response = await _api.post(AppEndPoint.login.login,
        data: {'UserName': userName, 'Password': password},
      );

      return LoginResponseModel.fromApi(response.data, userName, password);

    } on DioException catch (e) {
      // Manejo de errores estilo Axios
      final msg = e.response?.data['message'] ?? 'Error de conexión';

      Console.log( '⚠️ Error en login: $msg', layer: 'AuthApi');

      return LoginResponseModel(isAuthenticated: false, message: msg);
    }
  }
}
