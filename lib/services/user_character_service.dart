import 'package:creatures_online_client/models/user_character_model.dart';
import 'package:creatures_online_client/models/user_character_slot_model.dart';
import 'package:creatures_online_client/services/auth_service.dart';
import 'package:dio/dio.dart';

import '../models/response_model.dart';
import '../utils/utils.dart';

class UserCharacterService {
  final _dio = Dio();
  final _authService = AuthService();

  Future<List<UserCharacterModel>> get() async {
    try {
      final response = await _dio.get<dynamic>(
        '${getAPI()}/user/character',
        options: await _authService.getToken(),
      );
      return UserCharacterModel.listFromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response?.data);
    }
  }

  Future<ResponseModel> updateSlot(List<UserCharacterSlotModel> list) async {
    try {
      final response = await _dio.put<dynamic>(
        '${getAPI()}/user/character/slot',
        data: UserCharacterSlotModel.modelToJson(list),
        options: await _authService.getToken(),
      );
      return ResponseModel.fromMap(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(
            error: true, message: 'Conexão com o servidor falhou');
      }
      return ResponseModel.fromMap(e.response?.data);
    }
  }
}
