import 'package:comunidadesucv/core/enum/friendship_state.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/core/models/user_friendship.dart';

import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/detail_member_repository.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/list_membership_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/friendships_repository.dart';
import 'package:comunidadesucv/features/perfil/data/repository/perfil_repository.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommunityMemberController extends GetxController {
 int spaceId = Get.arguments;
  final box = GetStorage();

  ListMembershipRepository listMembershipRepository =
      ListMembershipRepository();
  FriendshipsRepository friendshipsRepository = FriendshipsRepository();
  PerfilRepository perfilRepository = PerfilRepository();
  DetailMemberRepository detailMemberRepository = DetailMemberRepository();

  final RxList<MembershipInfo> memberships = <MembershipInfo>[].obs;
  final RxList<MembershipInfo> recommendedMemberships = <MembershipInfo>[].obs;
  final RxList<MembershipInfo> filteredMemberships = <MembershipInfo>[].obs;

  final RxMap<int, FriendshipState> friendshipStates =
      <int, FriendshipState>{}.obs;

  final searchController = TextEditingController();
  final RxString searchText = ''.obs;
  ScrollController scrollController = ScrollController();

  int _page = 1;
  final int _limit = 50;
  final RxBool isLoading = false.obs;
  final RxBool hasMore = true.obs;

  final Rx<UserDetail> user = UserDetail.empty().obs;

  @override
  void onReady() async {
    super.onReady();
    await init();
  }

  Future<void> init() async {
    await _loadUser();
    await _initFriendshipsData();
    await _loadMemberships();

    _setupListeners();
  }

  void _setupListeners() {
    searchController.addListener(() {
      searchText.value = searchController.text;
    });

    ever(searchText, (_) => _filterMembers());

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        if (hasMore.value && !isLoading.value) {
          _loadMemberships();
        }
      }
    });
  }

  Future<void> _loadUser() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  Future<void> _initFriendshipsData() async {
    final results = await Future.wait([
      friendshipsRepository.getFriendshipReceived(),
      friendshipsRepository.getFriendshipSent(),
      perfilRepository.getFriendship()
    ]);

    final List<UserFriendship> received = results[0];
    final List<UserFriendship> sent = results[1];
    final List<UserFriendship> friends = results[2];

    for (var user in friends) {
      friendshipStates[user.id] = FriendshipState.FRIEND;
    }

    for (var user in sent) {
      friendshipStates.putIfAbsent(user.id, () => FriendshipState.REQUEST_SENT);
    }

    for (var user in received) {
      friendshipStates.putIfAbsent(
          user.id, () => FriendshipState.REQUEST_RECEIVED);
    }
  }

  void deleteFriend(String memberId) async {
    bool response = await detailMemberRepository.deleteFriend(memberId);
    if (response) {
      update();
    }
  }

  void sendAndAcceptRequestFriend(String memberId) async {
    bool response =
        await detailMemberRepository.sendAndAcceptRequestFriend(memberId);
    if (response) {
      update();
    }
  }

  String getDisplayName(String name) {
    const maxChars = 22;
    return name.length > maxChars ? '${name.substring(0, maxChars)}...' : name;
  }

  FriendshipState getFriendshipState(int userId) {
    if (userId == user.value.id) {
      return FriendshipState.SELF;
    }
    return friendshipStates[userId] ?? FriendshipState.NO_FRIEND;
  }

  void updateFriendshipState(int userId, FriendshipState state) {
    friendshipStates[userId] = state;
    friendshipStates.refresh();
  }

  Future<void> _loadMemberships({bool isRefresh = false}) async {
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
      _filterMembers();

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
    String text = searchText.value.toLowerCase();

    if (text.isEmpty) {
      filteredMemberships.assignAll(memberships);
    } else {
      filteredMemberships.assignAll(memberships.where((member) {
        return member.user.displayName.toLowerCase().contains(text);
      }).toList());
    }
  }

  Future<void> refreshList() async {
    await _loadMemberships(isRefresh: true);
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}