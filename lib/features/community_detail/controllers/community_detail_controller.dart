import 'dart:io';
import 'dart:typed_data';

import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/community_detail_repository.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CommunityDetailController extends GetxController {
  final box = GetStorage();
  final Space space = Get.arguments;
  final RxBool isButtonMember = false.obs;
  var isLoading = false.obs;
  var isLoadingButton = false.obs;
  var isLoadingLastPost = false.obs;

  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  SplashRepository splashRepository = SplashRepository();
  CommunityDetailRepository communityDetailRepository =
      CommunityDetailRepository();
  final RxList<Post> dataPost = <Post>[].obs;

  final Rx<UserDetail> user = UserDetail.empty().obs;

  final RxMap<int, Uint8List> imagesMap = <int, Uint8List>{}.obs;
  final isRulesExpanded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoadingLastPost.value = true;
    Future.wait([
      _loadUser(),
      _loadCommunity(),
    ]);
  }

  // Método para alternar la visibilidad de las reglas
  void toggleRulesExpanded() {
    isRulesExpanded.value = !isRulesExpanded.value;
  }

  Future<void> loadImage(int idFile, String token) async {
    if (imagesMap.containsKey(idFile)) return;

    final cacheDir = await getTemporaryDirectory();
    final file = File('${cacheDir.path}/image_$idFile.jpg');

    if (await file.exists()) {
      imagesMap[idFile] = await file.readAsBytes();
      return;
    }

    final response = await http.get(
      Uri.parse(
          "https://comunidadesucv.uvcv.edu.pe/api/v1/file/download/$idFile"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      imagesMap[idFile] = response.bodyBytes;
      await file.writeAsBytes(response.bodyBytes);
    }
  }

  Future<void> _loadUser() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  Future<void> _loadCommunity() async {
    if (user.value.spaces.any((userSpace) => userSpace.id == space.id)) {
      isButtonMember.value = true;
    } else {
      isButtonMember.value = false;
    }
    await loadLastPostContainer();
  }

  Future<void> loadLastPostContainer() async {
    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.contentContainerId, 20, 1);

      final filteredPostsArchived = response.results
          .where((item) => item.content.metadata.archived == false)
          .toList();
      final filteredPosts = filteredPostsArchived.where((post) {
        return post.content.files.isNotEmpty;
      }).toList();

      dataPost.assignAll(filteredPosts);
    } catch (e) {
      print("Error cargando posts: $e");
    } finally {
      isLoadingLastPost.value = false;
    }
  }

  void toggleButton() async {
    if (!isButtonMember.value && !isLoadingButton.value) {
      isLoadingButton.value = true;

      await communityDetailRepository.addMembershipsSpace(
          space.id, user.value.id);

      confettiController.play();
      isButtonMember.value = true;

      isLoadingButton.value = false;
    } else if (isButtonMember.value && !isLoadingButton.value) {
      isLoadingButton.value = true;

      await communityDetailRepository.deleteMembershipsSpace(
          space.id, user.value.id);

      isButtonMember.value = false;

      isLoadingButton.value = false;
    }
    user.value = await splashRepository.getUser(user.value.account!.username);
    box.write("user", user.value);
  }
}
