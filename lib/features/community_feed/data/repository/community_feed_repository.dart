import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_feed/data/dto/comments_response_dto.dart';
import 'package:comunidadesucv/features/community_feed/data/provider/community_feed_provider.dart';

class CommunityFeedRepository {
  CommunityFeedProvider communityFeedProvider = CommunityFeedProvider();

  Future<bool> addLike(String model, int pk) async {
    final response = await communityFeedProvider.addLike(model, pk);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    final code = response.data["code"];
    if (code == 200) {
      return true;
    } else {
      throw Exception("Error al dar like. Código: $code");
    }
  }

  Future<CommentItem> addComment(String model, int pk, String message) async {
    final response = await communityFeedProvider.addComment(model, pk, message);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return CommentItem.fromJson(response.data);
  }

  Future<CommentsResponseDto> getComments(int pk, int page, int limit) async {
    final response = await communityFeedProvider.getComments(pk, page, limit);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }

    return CommentsResponseDto.fromJson(response.data);
  }
}
