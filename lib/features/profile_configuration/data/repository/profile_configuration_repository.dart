import 'package:comunidadesucv/features/profile_configuration/data/provider/profile_configuration_provider.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';

class ProfileConfigurationRepository {
  ProfileConfigurationProvider profileConfigurationProvider =
      ProfileConfigurationProvider();

  Future<UserDetail> updateTagsUser(int idUser, List<String> tag, String preferenceName) async {
    final response =
        await profileConfigurationProvider.updateTagsUser(idUser, tag, preferenceName);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }
    return UserDetail.fromJson(response.data);
  }
}
