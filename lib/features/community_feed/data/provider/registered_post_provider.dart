import 'package:comunidadesucv/features/community_feed/controllers/registered_post_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class RegisteredPostProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  RegisteredPostProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> publishPostMessage(
      String message, int postContainerId) async {
    try {
      Dio dioClient = Dio();

      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/post/container/$postContainerId',
        data: {
          "data": {
            "message": message,
            "content": {
              "topics": []
            }
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

 Future<Response> uploadFilesPost(List<MediaAttachment> mediaAttachments, int postId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";
      
      FormData formData = FormData();
      
      for (var mediaAttachment in mediaAttachments) {
        if (mediaAttachment.isFile && mediaAttachment.path != null) {
          String fileName = mediaAttachment.path!.split('/').last;
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(
                mediaAttachment.path!,
                filename: fileName,
              ),
            ),
          );
        }
      }
      
      final response = await dioClient.post(
        '$baseUrl/post/$postId/upload-files',
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
}
