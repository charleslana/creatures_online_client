import 'package:creatures_online_client/models/auth_model.dart';
import 'package:creatures_online_client/models/register_model.dart';
import 'package:creatures_online_client/models/response_model.dart';
import 'package:creatures_online_client/services/shared_local_storage_service.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:dio/dio.dart';

class PublicService {
  final _dio = Dio();

  Future<String> getVersion() async {
    try {
      final response = await _dio.get<dynamic>('${getAPI()}/public/version');
      return response.data.toString();
    } on DioError catch (e) {
      if (e.response == null) {
        return Future.error('Conexão com o servidor falhou');
      }
      return Future.error(e.response?.data);
    }
  }

  Future<ResponseModel> register(RegisterModel register) async {
    try {
      final response = await _dio.post<dynamic>('${getAPI()}/public/user',
          data: register.toJson());
      return ResponseModel.fromMap(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: 'Conexão com o servidor falhou');
      }
      return ResponseModel.fromMap(e.response!.data);
    }
  }

  Future<ResponseModel> auth(AuthModel auth) async {
    try {
      final response = await _dio.post<dynamic>('${getAPI()}/public/auth',
          data: auth.toJson());
      final cookie = _getCookieFromHeader(response);
      await _saveAuth(auth, response.data['token'], cookie);
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: 'Conexão com o servidor falhou');
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

  Future<void> _saveAuth(AuthModel auth, String token, String cookie) async {
    final sharedLocalStorageService = SharedLocalStorageService();
    await sharedLocalStorageService.put(
        sharedLocalStorageService.email, auth.email);
    await sharedLocalStorageService.put(
        sharedLocalStorageService.password, auth.password);
    await sharedLocalStorageService.put(sharedLocalStorageService.token, token);
    await sharedLocalStorageService.put(
        sharedLocalStorageService.cookie, cookie);
  }
}
