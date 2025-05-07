import 'package:comunidadesucv/core/models/user_friendship.dart';
import 'package:comunidadesucv/features/perfil/data/provider/friendships_provider.dart';

class FriendshipsRepository {
  FriendshipsProvider friendshipsProvider = FriendshipsProvider();

  Future<List<UserFriendship>> getFriendshipReceived() async {
    final response = await friendshipsProvider.getFriendshipReceived();

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    final List<dynamic> dataList = response.data;
    return dataList.map((e) => UserFriendship.fromJson(e)).toList();
  }

    Future<List<UserFriendship>> getFriendshipSent() async {
    final response = await friendshipsProvider.getFriendshipSent();

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    final List<dynamic> dataList = response.data;
    return dataList.map((e) => UserFriendship.fromJson(e)).toList();
  }
}
