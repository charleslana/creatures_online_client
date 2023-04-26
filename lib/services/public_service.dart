import 'package:creatures_online_client/models/response_model.dart';
import 'package:creatures_online_client/models/user_mode.dart';
import 'package:creatures_online_client/services/shared_local_storage_service.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:dio/dio.dart';

class PublicService {
  final _dio = Dio();

  Future<ResponseModel> getVersion() async {
    try {
      final response = await _dio.get("${getAPI()}/public/version");
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ResponseModel> register(UserModel user) async {
    try {
      final response =
          await _dio.post("${getAPI()}/public/user", data: user.toJson());
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ResponseModel> auth(UserModel user) async {
    try {
      final response =
          await _dio.post("${getAPI()}/public/auth", data: user.toJson());
      final cookie = _getCookieFromHeader(response);
      _saveAuth(user, response.data["token"], cookie);
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }

  String _getCookieFromHeader(Response<dynamic> response) {
    final rawCookie = response.headers['set-cookie'];
    final cookie = rawCookie?.first;
    if (cookie != null) {
      final int index = cookie.indexOf(';');
      return (index == -1) ? cookie : cookie.substring(0, index);
    }
    return '';
  }

  void _saveAuth(UserModel user, String token, String cookie) {
    final sharedLocalStorageService = SharedLocalStorageService();
    sharedLocalStorageService.put(sharedLocalStorageService.email, user.email);
    sharedLocalStorageService.put(
        sharedLocalStorageService.password, user.password);
    sharedLocalStorageService.put(sharedLocalStorageService.token, token);
    sharedLocalStorageService.put(sharedLocalStorageService.cookie, cookie);
  }
}
