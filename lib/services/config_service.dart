import 'package:dio/dio.dart';

final dio = Dio();

class ConfigService {
  Future<String> getVersion() async {
    try {
      final response =
          await dio.get("http://192.168.0.103:9000/public/version");
      if (response.statusCode != 200) {
        return "0";
      }
      return response.data;
    } catch (e) {
      print(e);
      return "0";
    }
  }
}
