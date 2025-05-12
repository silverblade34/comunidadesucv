import 'package:comunidadesucv/features/communities/bindings/communities_binding.dart';
import 'package:comunidadesucv/features/communities/presentation/pages/communities_page.dart';
import 'package:comunidadesucv/features/community_detail/bindings/community_detail_binding.dart';
import 'package:comunidadesucv/features/community_member/bindings/detail_member_binding.dart';
import 'package:comunidadesucv/features/community_detail/presentation/pages/community_detail_page.dart';
import 'package:comunidadesucv/features/community_member/presentation/pages/detail_member_page.dart';
import 'package:comunidadesucv/features/community_feed/bindings/community_feed_binding.dart';
import 'package:comunidadesucv/features/community_feed/bindings/registered_post_binding.dart';
import 'package:comunidadesucv/features/community_feed/presentation/pages/community_feed_page.dart';
import 'package:comunidadesucv/features/community_feed/presentation/pages/registered_post_page.dart';
import 'package:comunidadesucv/features/community_forum/bindings/community_forum_binding.dart';
import 'package:comunidadesucv/features/community_forum/bindings/createnew_post_binding.dart';
import 'package:comunidadesucv/features/community_forum/presentation/pages/community_forum_page.dart';
import 'package:comunidadesucv/features/community_forum/presentation/pages/createnew_post_page.dart';
import 'package:comunidadesucv/features/community_member/bindings/community_member_binding.dart';
import 'package:comunidadesucv/features/community_member/presentation/pages/community_member_page.dart';
import 'package:comunidadesucv/features/intro/bindings/intro_binding.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro_page.dart';
import 'package:comunidadesucv/features/perfil/bindings/friendships_binding.dart';
import 'package:comunidadesucv/features/perfil/bindings/perfil_binding.dart';
import 'package:comunidadesucv/features/perfil/presentation/pages/friendships_page.dart';
import 'package:comunidadesucv/features/perfil/presentation/pages/perfil_page.dart';
import 'package:comunidadesucv/features/profile_configuration/bindings/profile_configuration_binding.dart';
import 'package:comunidadesucv/features/profile_configuration/presentation/pages/profile_configuration_page.dart';
import 'package:comunidadesucv/features/splash/bindings/splash_binding.dart';
import 'package:comunidadesucv/features/splash/presentation/pages/splash_page.dart';
import 'package:get/get.dart';
part 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.intro,
      page: () => const IntroPage(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: Routes.perfil,
      binding: PerfilBinding(),
      page: () => const PerfilPage(),
    ),
    GetPage(
      name: Routes.profileConfiguration,
      binding: ProfileConfigurationBinding(),
      page: () => const ProfileConfigurationPage(),
    ),
    GetPage(
      name: Routes.communities,
      binding: CommunitiesBinding(),
      page: () => const CommunitiesPage(),
    ),
    GetPage(
      name: Routes.communityDetail,
      binding: CommunityDetailBinding(),
      page: () => const CommunityDetailPage(),
    ),
    GetPage(
      name: Routes.communityFeed,
      binding: CommunityFeedBinding(),
      page: () => const CommunityFeedPage(),
    ),
    GetPage(
      name: Routes.communityMember,
      binding: CommunityMemberBinding(),
      page: () => const CommunityMemberPage(),
    ),
    GetPage(
      name: Routes.detailMember,
      binding: DetailMemberBinding(),
      page: () => const DetailMemberPage(),
    ),
    GetPage(
      name: Routes.communityForum,
      binding: CommunityForumBinding(),
      page: () => const CommunityForumPage(),
    ),
      GetPage(
      name: Routes.createForum,
      binding: CreateNewPostBinding(),
      page: () => const CreateNewPostPage(),
    ),
    GetPage(
      name: Routes.registeredPost,
      binding: RegisteredPostBinding(),
      page: () => const RegisteredPostPage(),
    ),
       GetPage(
      name: Routes.friendships,
      binding: FriendshipsBinding(),
      page: () => const FriendshipsPage(),
    ),
  ];
}
