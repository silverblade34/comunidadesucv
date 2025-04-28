import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class CommunitiesProvider {
  final box = GetStorage();
  late String token;

  CommunitiesProvider() {
    token = box.read("tokenStudent");
  }

  Future<Response> findSpaces() async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.get(
        '$baseUrl/space',
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          "${e.response?.data}",
        );
      } else {
        throw Exception("Error de conexión al servidor: ${e.message}");
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
