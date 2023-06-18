import 'package:creatures_online_client/services/auth_service.dart';
import 'package:dio/dio.dart';

import '../models/response_model.dart';
import '../models/user_character_model.dart';
import '../utils/utils.dart';

class UserCharacterService {
  final _dio = Dio();
  final _authService = AuthService();

  Future<ResponseModel> updateSlot(List<UserCharacterModel> ucs) async {
    try {
      final response = await _dio.put<dynamic>(
        '${getAPI()}/user/character',
        data: UserCharacterModel.modelToJson(ucs),
        options: await _authService.getToken(),
      );
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: 'Conexão com o servidor falhou');
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }
}