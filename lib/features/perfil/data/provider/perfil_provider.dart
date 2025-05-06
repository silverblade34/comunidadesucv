import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class PerfilProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  PerfilProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> getFriendship() async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.get(
        '$baseUrl/friendship',
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("${e.response?.data}");
      } else {
        throw Exception("Error de conexión al servidor: ${e.message}");
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
