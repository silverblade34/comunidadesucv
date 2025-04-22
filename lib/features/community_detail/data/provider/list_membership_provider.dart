import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['LINK_API'];
final staticToken = dotenv.env['TOKEN'];

class ListMembershipProvider {
  Future<Response> getSpaceMembers(int spaceId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

      final response = await dioClient.get(
        '$baseUrl/space/$spaceId/membership',
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

    Future<Response> getMemberId(String memberId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Bearer $staticToken";

      final response = await dioClient.get(
        '$baseUrl/user/$memberId',
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