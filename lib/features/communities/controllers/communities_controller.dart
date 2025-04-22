import 'package:comunidadesucv/core/models/account.dart';
import 'package:comunidadesucv/features/communities/data/repository/communities_repository.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/communities/data/dto/spaces_response.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommunitiesController extends GetxController {
  final box = GetStorage();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SplashRepository homeRepository = SplashRepository();
  CommunitiesRepository communitiesRepository = CommunitiesRepository();

  final RxList<Space> recommendedCommunities = <Space>[].obs;
  final RxList<Space> filteredCommunities = <Space>[].obs;
  final RxList<Space> dataCommunities = <Space>[].obs;
  final RxList<Space> spaces = <Space>[].obs;

  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  final Rx<UserDetail> user = UserDetail(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
      account: Account(
        id: 0,
        guid: '',
        username: '',
        email: '',
        visibility: 0,
        status: 0,
        tags: [],
        language: '',
        timeZone: '',
        contentcontainerId: 0,
        authclient: '',
        authclientId: null,
        lastLogin: '',
      ),
      profile: null,
      spaces: []).obs;

  final Rx<SpacesResponse?> spacesResponse = Rx<SpacesResponse?>(null);

  bool isdark = false;

  @override
  void onInit() async {
    super.onInit();
    filteredCommunities.assignAll(dataCommunities);

    _loadUser();
    _loadCommunities();

    ever(searchQuery, (_) {
      filterCommunities();
    });
  }

  void filterCommunities() {
    if (searchQuery.value.isEmpty) {
      filteredCommunities.assignAll(dataCommunities);
    } else {
      filteredCommunities.assignAll(dataCommunities
          .where((community) =>
              community.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              community.description
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              community.tags.any((tag) =>
                  tag.toLowerCase().contains(searchQuery.value.toLowerCase())))
          .toList());
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  void _loadUser() {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  void _loadCommunities() async {
    final response = await communitiesRepository.findSpaces();
    spaces.value = response.results;

    final userTags =
        user.value.account!.tags.map((e) => e.toLowerCase()).toSet();

    final List<Space> recommended = [];
    final List<Space> others = [];

    for (Space space in spaces) {
      final spaceTags = (space.tags).map((e) => e.toLowerCase()).toSet();

      final hasCommonTags = spaceTags.intersection(userTags).isNotEmpty;

      if (hasCommonTags) {
        recommended.add(space);
      } else {
        others.add(space);
      }
    }

    recommendedCommunities.assignAll(recommended);
    dataCommunities.assignAll(others);
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
