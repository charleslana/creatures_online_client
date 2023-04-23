import 'package:creatures_online_client/models/response_model.dart';
import 'package:creatures_online_client/models/user_mode.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class PublicService {
  Future<ResponseModel> getVersion() async {
    try {
      final response =
          await dio.get("${getAPI()}/public/version");
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }

  Future<ResponseModel> register(UserModel user) async {
    try {
      final response = await dio.post("${getAPI()}/public/user",
          data: user.toJson());
      return ResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response == null) {
        return ResponseModel(error: true, message: "Conexão com o servidor falhou");
      }
      return ResponseModel.fromJson(e.response?.data);
    }
  }
}
