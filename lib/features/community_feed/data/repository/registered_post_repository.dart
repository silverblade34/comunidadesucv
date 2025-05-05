import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_feed/controllers/registered_post_controller.dart';
import 'package:comunidadesucv/features/community_feed/data/provider/registered_post_provider.dart';

class RegisteredPostRepository {
  RegisteredPostProvider registeredFeedProvider = RegisteredPostProvider();

  Future<Post> publishPostMessage(String message, int postContainerId) async {
    final response = await registeredFeedProvider.publishPostMessage(
        message, postContainerId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    return Post.fromJson(response.data);
  }

  Future<void> uploadFilesPost(
      List<MediaAttachment> mediaAttachments, int postId) async {
    final response =
        await registeredFeedProvider.uploadFilesPost(mediaAttachments, postId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }
  }
}
