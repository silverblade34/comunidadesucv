import 'package:comunidadesucv/features/communities/data/provider/communities_provider.dart';
import 'package:comunidadesucv/features/communities/data/dto/spaces_response.dart';

class CommunitiesRepository {
  CommunitiesProvider communitiesProvider = CommunitiesProvider();

  Future<SpacesResponse> findSpaces() async {
    final response = await communitiesProvider.findSpaces();

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
