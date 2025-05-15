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
  final cacheKey = 'communities_cache';
  final cacheImagesKey = 'communities_images_cache';
  final cacheTimestampKey = 'communities_cache_timestamp';
  // 12 horas en milisegundos para la caducidad de la caché
  final cacheDuration = 6 * 60 * 60 * 1000;

  SplashRepository homeRepository = SplashRepository();
  CommunitiesRepository communitiesRepository = CommunitiesRepository();

  final RxList<Space> filteredCommunities = <Space>[].obs;
  final RxList<Space> allCommunities = <Space>[].obs;
  final RxList<Space> spaces = <Space>[].obs;
  final RxBool isLoading = false.obs;

  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  TextEditingController searchController = TextEditingController(text: "");

  final Rx<UserDetail> user = UserDetail.empty().obs;

  final Rx<SpacesResponse?> spacesResponse = Rx<SpacesResponse?>(null);

  bool isdark = false;

  @override
  void onInit() async {
    super.onInit();
    filteredCommunities.assignAll(allCommunities);

    _loadUser();

    // Primero cargamos desde caché, luego desde la API
    await _loadCommunitiesFromCache();
    if (_isCacheExpired()) {
      await _loadCommunitiesFromAPI();
    }

    ever(searchQuery, (_) {
      filterCommunities();
    });
  }

  // Verifica si la caché ha expirado
  bool _isCacheExpired() {
    final timestamp = box.read(cacheTimestampKey);
    if (timestamp == null) return true;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - timestamp) > cacheDuration;
  }

  // Método para cargar comunidades desde la caché
  Future<void> _loadCommunitiesFromCache() async {
    final cachedData = box.read(cacheKey);
    if (cachedData != null) {
      try {
        final cachedSpaces =
            (cachedData as List).map((e) => Space.fromJson(e)).toList();
        spaces.value = cachedSpaces;
        _processCommunities();
      } catch (e) {
        debugPrint('Error al cargar datos desde caché: $e');
      }
    }
  }

  // Método para cargar comunidades desde la API
  Future<void> _loadCommunitiesFromAPI() async {
    isLoading.value = true;
    try {
      final response = await communitiesRepository.findSpaces();
      spaces.value = response.results;

      // Guardar en caché
      box.write(cacheKey, spaces.map((e) => e.toJson()).toList());
      box.write(cacheTimestampKey, DateTime.now().millisecondsSinceEpoch);

      _processCommunities();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _processCommunities() {
    allCommunities.assignAll(spaces);
    filteredCommunities.assignAll(allCommunities);
  }

  Future<void> refreshCommunities() async {
    return _loadCommunitiesFromAPI();
  }

  void filterCommunities() {
    if (searchQuery.value.isEmpty) {
      filteredCommunities.assignAll(allCommunities);
    } else {
      filteredCommunities.assignAll(allCommunities
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
    searchController.clear();
  }

  void _loadUser() {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
    } else {
      Get.snackbar("Error", "No se encontró información del usuario",
          backgroundColor: Get.theme.colorScheme.errorContainer,
          colorText: Get.theme.colorScheme.onErrorContainer);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
