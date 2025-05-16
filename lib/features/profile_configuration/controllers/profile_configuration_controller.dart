import 'package:comunidadesucv/features/profile_configuration/data/repository/profile_configuration_repository.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileConfigurationController extends GetxController {
  final box = GetStorage();
  ProfileConfigurationRepository profileConfigurationRepository =
      ProfileConfigurationRepository();
  final RxList<Map<String, dynamic>> tags = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  TextEditingController preferenceName = TextEditingController(text: "");

  final RxString selectedTag = ''.obs;
  final RxString ciclo = ''.obs;

  final Rx<UserDetail> user = UserDetail.empty().obs;

  @override
  void onInit() {
    super.onInit();
    _loadTagsFromStorage();
    _loadUser();
  }

  void _loadTagsFromStorage() {
    final storedTags = box.read<List>("tags") ?? [];

    tags.assignAll(
      storedTags
          .map((tag) => {
                'tag': tag,
                'isSelected': false,
              })
          .toList(),
    );
  }

  void handleTagPress(String tag) {
    final index = tags.indexWhere((element) => element['tag'] == tag);
    if (index != -1) {
      tags[index] = {
        ...tags[index],
        'isSelected': !tags[index]['isSelected'],
      };
    }
  }

  List<String> getSelectedTags() {
    return tags
        .where((element) => element['isSelected'] == true)
        .map((e) => e['tag'] as String)
        .toList();
  }

  void _loadUser() {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
      ciclo.value = box.read("ciclo");
      preferenceName.text = user.value.profile!.preferredName != null ? "${user.value.profile!.preferredName}": "";
      _updateSelectedTags(user.value.account?.tags ?? []);
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  void _updateSelectedTags(List<String> userTags) {
    for (int i = 0; i < tags.length; i++) {
      final tagName = tags[i]['tag'];
      tags[i] = {
        ...tags[i],
        'isSelected': userTags.contains(tagName),
      };
    }
  }

  loadCommunitiesScreen() async {
    List<String> selectedTags = getSelectedTags();
    UserDetail userUpdate = await profileConfigurationRepository.updateTagsUser(
        user.value.id, selectedTags, preferenceName.text);
    box.write("user", userUpdate);
  }
}
