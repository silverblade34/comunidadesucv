import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/provider/community_detail_provider.dart';

class CommunityDetailRepository {
  CommunityDetailProvider communityDetailProvider = CommunityDetailProvider();

  Future<Space> getSpace(int spaceId) async {
    final response = await communityDetailProvider.getSpace(spaceId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return Space.fromJson(response.data);
  }

  Future<void> addMembershipsSpace(int spaceId, int userId) async {
    final response =
        await communityDetailProvider.addMembershipsSpace(spaceId, userId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }
  }

  Future<void> deleteMembershipsSpace(int spaceId, int userId) async {
    final response =
        await communityDetailProvider.deleteMembershipsSpace(spaceId, userId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }
  }

  Future<ContentSpaceDto> postContainerSpace(
      int containerId, int limit, int page) async {
    final response = await communityDetailProvider.postContainerSpace(
        containerId, limit, page);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }
    return ContentSpaceDto.fromJson(response.data);
  }
}
