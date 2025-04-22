import 'dart:typed_data';

import 'package:comunidadesucv/core/models/comment.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/community_detail_repository.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CommunityFeedController extends GetxController {
  final Space space = Get.arguments;
  SplashRepository splashRepository = SplashRepository();
  CommunityDetailRepository communityDetailRepository =
      CommunityDetailRepository();

  final RxList<Post> dataPost = <Post>[].obs;
  var isLoading = false.obs;
  final box = GetStorage();

  final RxMap<int, Uint8List> imagesMap = <int, Uint8List>{}.obs;
  final RxMap<int, bool> userLikes = <int, bool>{}.obs;
  final RxMap<int, List<Comment>> postComments = <int, List<Comment>>{}.obs;

  final Rx<UserDetail> user = UserDetail(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
      account: null,
      profile: null,
      spaces: []).obs;

  @override
  void onInit() async {
    super.onInit();
    _loadUser();
    _loadLastPostContainer();
  }

  void _loadUser() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
      user.value = await splashRepository.getUser(user.value.account!.username);
      box.write("user", user.value);
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  void toggleLike(int postId) {
    if (userLikes.containsKey(postId)) {
      userLikes[postId] = !userLikes[postId]!;
    } else {
      userLikes[postId] = true;
    }

    final postIndex = dataPost.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      if (userLikes[postId]!) {
        dataPost[postIndex].content.likes.total++;
      } else {
        dataPost[postIndex].content.likes.total--;
      }
    }
  }

  void addComment(int postId, String text) {
    if (text.trim().isEmpty) return;

    final comment = Comment(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
      username:
          "${user.value.profile?.firstname ?? ""} ${user.value.profile?.lastname ?? ""}",
      userImage: user.value.profile!.imageUrl,
      timestamp: DateTime.now(),
    );

    if (!postComments.containsKey(postId)) {
      postComments[postId] = <Comment>[].obs;
    }

    postComments[postId]!.add(comment);

    // Actualiza el conteo de comentarios en el post
    final postIndex = dataPost.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      dataPost[postIndex].content.comments.total++;
    }
  }

  String cleanMessage(String message) {
    final cleanedMessage = message.replaceAll(
        RegExp(r'!\[\]\(file-guid:[a-zA-Z0-9-]+ \".*?\"\)'), '');
    return cleanedMessage;
  }

  Future<void> loadImage(int idFile, String token) async {
    if (imagesMap.containsKey(idFile)) return;

    final response = await http.get(
      Uri.parse(
          "https://comunidadesucv.uvcv.edu.pe/api/v1/file/download/$idFile"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      imagesMap[idFile] = response.bodyBytes;
    }
  }

  void _loadLastPostContainer() async {
    isLoading.value = true;
    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.contentContainerId, 100);

      final filteredPosts = response.results;

      dataPost.assignAll(filteredPosts);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
