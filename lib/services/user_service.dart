import 'package:creatures_online_client/services/shared_local_storage_service.dart';
import 'package:dio/dio.dart';

import '../models/user_mode.dart';
import '../utils/utils.dart';

class UserService {
  final dio = Dio();
  final sharedLocalStorageService = SharedLocalStorageService();

  Future<UserModel> getAuthLogin() async {
    final email = await sharedLocalStorageService
        .get<String>(sharedLocalStorageService.email);
    final password = await sharedLocalStorageService
        .get<String>(sharedLocalStorageService.password);
    if (email != null && password != null) {
      return UserModel(email: email, password: password);
    }
    return Future.error("Falha na autenticação");
  }

  Future<UserModel> getDetails() async {
    try {
      final cookie = await _getCookie();
      final token = await _getToken();
      final response = await dio.get(
        "${getAPI()}/user/details",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'cookie': cookie,
          },
        ),
      );
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response?.data);
    }
  }

  Future<void> logout() async {
    await sharedLocalStorageService.delete(sharedLocalStorageService.email);
    await sharedLocalStorageService.delete(sharedLocalStorageService.password);
    await sharedLocalStorageService.delete(sharedLocalStorageService.cookie);
    await sharedLocalStorageService.delete(sharedLocalStorageService.token);
  }

  Future<String> _getCookie() async {
    final cookie = await sharedLocalStorageService
        .get<String>(sharedLocalStorageService.cookie);
    return cookie ?? "";
  }

  Future<String> _getToken() async {
    final token = await sharedLocalStorageService
        .get<String>(sharedLocalStorageService.token);
    return token ?? "";
  }
}
