import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['LINK_API'];
final staticToken = dotenv.env['TOKEN'];

class SplashProvider {
  Future<Response> getUser(String username) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

      final response = await dioClient.get(
        '$baseUrl/user/get-by-username?username=$username',
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

  Future<Response> getTags() async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

      final response = await dioClient.get(
        '$baseUrl/tag',
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

  Future<Response> getUserTrilce(
      String code, String username, String firstName, String lastName) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

      final response = await dioClient.get(
        '$baseUrl/user/trilce?codigo=$code&username=$username&nombre=$firstName&apellido=$lastName',
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

  Future<Response> findSpaces() async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

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
