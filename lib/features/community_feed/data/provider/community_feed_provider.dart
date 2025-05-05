import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class CommunityFeedProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  CommunityFeedProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> addLike(String model, int pk) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/like',
        data: {"model": model, "pk": pk},
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

  Future<Response> addComment(String model, int pk, String comment) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/comment',
        data: {
          "objectModel": model,
          "objectId": pk,
          "Comment": {"message": comment}
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

  Future<Response> getComments(int pk, int page, int limit) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";
      final response = await dioClient.get(
        '$baseUrl/comment/find-by-object?objectModel=humhub\\modules\\post\\models\\Post&objectId=$pk&page=$page&limit=$limit',
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
