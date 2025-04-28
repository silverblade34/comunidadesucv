import 'package:comunidadesucv/features/communities/bindings/communities_binding.dart';
import 'package:comunidadesucv/features/communities/presentation/pages/communities_page.dart';
import 'package:comunidadesucv/features/community_detail/bindings/community_detail_binding.dart';
import 'package:comunidadesucv/features/community_detail/bindings/detail_member_binding.dart';
import 'package:comunidadesucv/features/community_detail/bindings/forum_binding.dart';
import 'package:comunidadesucv/features/community_detail/bindings/list_members_binding.dart';
import 'package:comunidadesucv/features/community_detail/presentation/pages/community_detail_page.dart';
import 'package:comunidadesucv/features/community_detail/presentation/pages/detail_member_page.dart';
import 'package:comunidadesucv/features/community_detail/presentation/pages/forum_page.dart';
import 'package:comunidadesucv/features/community_detail/presentation/pages/list_members_page.dart';
import 'package:comunidadesucv/features/community_feed/bindings/community_feed_binding.dart';
import 'package:comunidadesucv/features/community_feed/bindings/registered_post_binding.dart';
import 'package:comunidadesucv/features/community_feed/presentation/pages/community_feed_page.dart';
import 'package:comunidadesucv/features/community_feed/presentation/pages/registered_post_page.dart';
import 'package:comunidadesucv/features/intro/bindings/intro_binding.dart';
import 'package:comunidadesucv/features/intro/presentation/pages/intro_page.dart';
import 'package:comunidadesucv/features/perfil/bindings/perfil_binding.dart';
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
      name: Routes.listMembers,
      binding: ListMembersBinding(),
      page: () => const ListMembersPage(),
    ),
    GetPage(
      name: Routes.detailMember,
      binding: DetailMemberBinding(),
      page: () => const DetailMemberPage(),
    ),
    GetPage(
      name: Routes.forum,
      binding: ForumBinding(),
      page: () => const ForumPage(),
    ),
    GetPage(
      name: Routes.registeredPost,
      binding: RegisteredPostBinding(),
      page: () => const RegisteredPostPage(),
    ),
  ];
}
