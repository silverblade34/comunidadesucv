import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class CommunityForumProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  CommunityForumProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> questionsContainerSpace(
      int containerId, int limit, int page, String search) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.get(
        '$baseUrl/questions/container/$containerId?page=$page&limit=$limit&search=$search',
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

  Future<Response> getAnswers(int questionId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.get(
        '$baseUrl/questions/$questionId/answers',
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

  Future<Response> voteUpAnswers(int answerId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/questions/answers/$answerId/vote-up',
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

  Future<Response> voteDownAnswers(int answerId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/questions/answers/$answerId/vote-down',
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

  Future<Response> publishAnswerQuestion(int questionId, String answer) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/questions/$questionId/answers',
        data: {
          "QuestionAnswer": {"answer": answer}
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

  Future<Response> publishQuestion(
      String title, String message, int postContainerId) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/questions/container/$postContainerId',
        data: {
          "Question": {
            "question": title,
            "description": message,
          }
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
}
