import 'package:comunidadesucv/features/community_detail/data/provider/detail_member_provider.dart';

class DetailMemberRepository {
  DetailMemberProvider detailMemberProvider = DetailMemberProvider();

  Future<bool> deleteFriend(String userId) async {
    final response = await detailMemberProvider.deleteFriend(userId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    } else if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> sendAndAcceptRequestFriend(String userId) async {
    final response =
        await detailMemberProvider.sendAndAcceptRequestFriend(userId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    } else if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
