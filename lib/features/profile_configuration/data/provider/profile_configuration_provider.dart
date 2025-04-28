import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class ProfileConfigurationProvider {
  final box = GetStorage();

  Future<Response> updateTagsUser(
      int idUser, List<String> tags, String preferenceName) async {
    try {
      Dio dioClient = Dio();
      String tokenAdmin = box.read("tokenAdmin");

      dioClient.options.headers["Authorization"] = "Bearer $tokenAdmin";

      final body = {
        "account": {
          "tagsField": tags,
        },
        "profile": {"preferred_name": preferenceName}
      };

      final response = await dioClient.put(
        '$baseUrl/user/$idUser',
        data: body,
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
