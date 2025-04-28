import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/memberships_space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/provider/list_membership_provider.dart';

class ListMembershipRepository {
  ListMembershipProvider listMembershipProvider = ListMembershipProvider();

  Future<MembershipsSpaceDto> getSpaceMembers(int spaceId, int page, int limit) async {
    final response = await listMembershipProvider.getSpaceMembers(spaceId, page, limit);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return MembershipsSpaceDto.fromJson(response.data);
  }

  Future<UserDetail> getMemberId(String memberId) async {
    final response = await listMembershipProvider.getMemberId(memberId);
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
