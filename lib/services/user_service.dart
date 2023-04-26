import 'package:creatures_online_client/services/auth_service.dart';
import 'package:creatures_online_client/services/shared_local_storage_service.dart';
import 'package:dio/dio.dart';

import '../models/response_model.dart';
import '../models/user_mode.dart';
import '../utils/utils.dart';

class UserService {
  final _dio = Dio();
  final _sharedLocalStorageService = SharedLocalStorageService();
  final _authService = AuthService();

  Future<UserModel> getAuthLogin() async {
    final email = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.email);
    final password = await _sharedLocalStorageService
        .get<String>(_sharedLocalStorageService.password);
    if (email != null && password != null) {
      return UserModel(email: email, password: password);
    }
    return Future.error("Falha na autenticação");
  }

  Future<UserModel> getDetails() async {
    try {
      final response = await _dio.get(
        "${getAPI()}/user/details",
        options: await _authService.getToken(),
      );
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response?.data);
    }
  }

  Future<ResponseModel> updateUserName(String name) async {
    try {
      final response = await _dio.put(
        "${getAPI()}/user",
        data: {
          "name": name,
        },
        options: await _authService.getToken(),
      );
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }

  Future<void> logout() async {
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.email);
    await _sharedLocalStorageService
        .delete(_sharedLocalStorageService.password);
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.cookie);
    await _sharedLocalStorageService.delete(_sharedLocalStorageService.token);
  }
}
