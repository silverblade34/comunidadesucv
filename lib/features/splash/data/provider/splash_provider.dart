import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class SplashProvider {
  final box = GetStorage();

  Future<Response> loginAdmin() async {
    try {
      Dio dioClient = Dio();
      String username = "admin_comunidades";
      String password = "admin_password";

      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await dioClient.post(
        '$baseUrl/auth/login',
        data: formData,
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

  Future<Response> getUser(String username) async {
    try {
      Dio dioClient = Dio();
      String tokenAdmin = box.read("tokenAdmin");

      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

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

  Future<Response> authImpersonate(int userId) async {
    try {
      Dio dioClient = Dio();
      String tokenAdmin = box.read("tokenAdmin");

      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final response = await dioClient.post(
        '$baseUrl/auth/impersonate',
        data: {
          "userId": userId,
        },
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

  Future<Response> getTags() async {
    try {
      Dio dioClient = Dio();

      String tokenAdmin = box.read("tokenAdmin");
      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

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
      String tokenAdmin = box.read("tokenAdmin");

      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

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
}
