import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class CommunityDetailProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  CommunityDetailProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> getSpace(int spaceId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final response = await dioClient.get(
        '$baseUrl/space/$spaceId',
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

  Future<Response> addMembershipsSpace(int spaceId, int userId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final response = await dioClient.post(
        '$baseUrl/space/$spaceId/membership/$userId',
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

  Future<Response> deleteMembershipsSpace(int spaceId, int userId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final response = await dioClient.delete(
        '$baseUrl/space/$spaceId/membership/$userId',
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

  Future<Response> postContainerSpace(int containerId, int limit, int page) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final response = await dioClient.get(
        '$baseUrl/post/container/$containerId?page=$page&limit=$limit',
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
