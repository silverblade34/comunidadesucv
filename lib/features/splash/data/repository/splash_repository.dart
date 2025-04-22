import 'package:comunidadesucv/features/communities/data/dto/spaces_response.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/splash/data/provider/splash_provider.dart';

class SplashRepository {
  SplashProvider splashProvider = SplashProvider();

  Future<UserDetail> getUser(String username) async {
    final response = await splashProvider.getUser(username);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return UserDetail.fromJson(response.data);
  }

  Future<UserDetail> getUserTrilce(
      String code, String username, String firstName, String lastName) async {
    final response =
        await splashProvider.getUserTrilce(code, username, firstName, lastName);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return UserDetail.fromJson(response.data);
  }

  Future<List<String>> getTags() async {
    final response = await splashProvider.getTags();
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return List<String>.from(response.data);
  }

  Future<SpacesResponse> findSpaces() async {
    final response = await splashProvider.findSpaces();

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return SpacesResponse.fromJson(response.data);
  }
}
