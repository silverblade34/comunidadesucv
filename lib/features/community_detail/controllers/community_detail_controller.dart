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
  final int spaceId = Get.arguments;
  final RxBool isButtonMember = false.obs;
  var isLoading = false.obs;

  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  SplashRepository splashRepository = SplashRepository();
  CommunityDetailRepository communityDetailRepository =
      CommunityDetailRepository();
  final RxList<Post> dataPost = <Post>[].obs;

  final Rx<Space> space = Space.empty().obs;
  final Rx<UserDetail> user = UserDetail(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
      account: null,
      profile: null,
      spaces: []).obs;

  final RxMap<int, Uint8List> imagesMap = <int, Uint8List>{}.obs;

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

  @override
  void onInit() async {
    super.onInit();
    _loadUser();
    _loadCommunity();
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

  void _loadCommunity() async {
    final response = await communityDetailRepository.getSpace(spaceId);
    space.value = response;
    _loadLastPostContainer();

    if (user.value.spaces.any((userSpace) => userSpace.id == spaceId)) {
      isButtonMember.value = true;
    } else {
      isButtonMember.value = false;
    }
  }

  void _loadLastPostContainer() async {
    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.value.contentContainerId, 4);

      final filteredPosts = response.results.where((post) {
        return post.content.files.isNotEmpty;
      }).toList();

      if (filteredPosts.isNotEmpty) {
        print("Estructura de files en el primer post:");
        print(filteredPosts[0].content.files);
      }

      dataPost.assignAll(filteredPosts);
    } catch (e) {
      print("Error cargando posts: $e");
    }
  }

  void toggleButton() async {
    if (!isButtonMember.value && !isLoading.value) {
      isLoading.value = true;

      await communityDetailRepository.addMembershipsSpace(
          spaceId, user.value.id);

      confettiController.play();
      isButtonMember.value = true;

      isLoading.value = false;
    } else if (isButtonMember.value && !isLoading.value) {
      isLoading.value = true;

      await communityDetailRepository.deleteMembershipsSpace(
          spaceId, user.value.id);

      isButtonMember.value = false;

      isLoading.value = false;
    }
    user.value = await splashRepository.getUser(user.value.account!.username);
    box.write("user", user.value);
  }
}
