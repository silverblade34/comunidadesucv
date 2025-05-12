import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

final baseUrl = dotenv.env['LINK_API'];

class DetailMemberProvider {
  final box = GetStorage();
  late String token;
  late String tokenAdmin;

  DetailMemberProvider() {
    token = box.read("tokenStudent");
    tokenAdmin = box.read("tokenAdmin");
  }

  Future<Response> deleteFriend(String userId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";
      print(jsonEncode({"friend_user_id": int.parse(userId)}));
      final response = await dioClient.delete(
        '$baseUrl/friendship',
        data: {"friend_user_id": int.parse(userId)},
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

  Future<Response> sendAndAcceptRequestFriend(String userId) async {
    try {
      Dio dioClient = Dio();
      dioClient.options.headers["Authorization"] = "Impersonate $token";

      final response = await dioClient.post(
        '$baseUrl/friendship',
        data: {"friend_user_id": int.parse(userId)},
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
