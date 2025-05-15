import 'package:comunidadesucv/features/communities/data/dto/user_info.dart';
import 'package:comunidadesucv/features/perfil/data/provider/perfil_provider.dart';

class PerfilRepository {
  PerfilProvider perfilProvider = PerfilProvider();

  Future<List<UserInfo>> getFriendship() async {
    final response = await perfilProvider.getFriendship();

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    final List<dynamic> dataList = response.data;
    return dataList.map((e) => UserInfo.fromJson(e)).toList();
  }
}
