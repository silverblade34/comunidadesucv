import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListMembersController extends GetxController {
  int spaceId = Get.arguments;
  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  final RxList<MembershipInfo> memberships = <MembershipInfo>[].obs;
  final RxList<MembershipInfo> recommendedMemberships = <MembershipInfo>[].obs;
  final RxList<MembershipInfo> filteredMemberships = <MembershipInfo>[].obs;

  TextEditingController searchController = TextEditingController(text: "");
  ScrollController scrollController = ScrollController();

  int _page = 1;
  final int _limit = 10;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMemberships();
    searchController.addListener(_filterMembers);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (hasMore.value && !isLoading.value) {
          _loadMemberships();
        }
      }
    });
  }

  void _loadMemberships({bool isRefresh = false}) async {
    if (isLoading.value) return;

    isLoading.value = true;
    if (isRefresh) {
      _page = 1;
      memberships.clear();
      filteredMemberships.clear();
      recommendedMemberships.clear();
      hasMore.value = true;
    }

    final response =
        await listMembershipRepository.getSpaceMembers(spaceId, _page, _limit);

    if (response.results.isEmpty) {
      hasMore.value = false;
    } else {
      memberships.addAll(response.results);
      filteredMemberships.assignAll(memberships);

      final List<MembershipInfo> recommended = [];
      for (MembershipInfo membership in response.results) {
        final membershipTags =
            membership.user.tags.map((e) => e.toLowerCase()).toSet();
        final hasCommonTags = membershipTags.isNotEmpty;
        if (hasCommonTags) {
          recommended.add(membership);
        }
      }
      recommendedMemberships.addAll(recommended);

      _page++;
    }

    isLoading.value = false;
  }

  void _filterMembers() {
    String searchText = searchController.text.toLowerCase();

    if (searchText.isEmpty) {
      filteredMemberships.value = memberships;
    } else {
      filteredMemberships.value = memberships.where((member) {
        return member.user.displayName.toLowerCase().contains(searchText);
      }).toList();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.removeListener(_filterMembers);
    searchController.dispose();
    super.onClose();
  }
}
