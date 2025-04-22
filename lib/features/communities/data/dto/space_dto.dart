import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';
import 'package:comunidadesucv/features/communities/data/dto/owner_dto.dart';

class Space {
  final int id;
  final String guid;
  final String name;
  final String description;
  final String url;
  final int contentContainerId;
  final int visibility;
  final int joinPolicy;
  final int status;
  final List<String> tags;
  final Owner owner;
  final int hideMembers;
  final int hideAbout;
  final int hideActivities;
  final int hideFollowers;
  final String indexUrl;
  final String indexGuestUrl;
  final String profileImage;
  final String coverImage;
  final int membersCount;
  final List<MembershipInfo> lastMemberships;

  Space({
    required this.id,
    required this.guid,
    required this.name,
    required this.description,
    required this.url,
    required this.contentContainerId,
    required this.visibility,
    required this.joinPolicy,
    required this.status,
    required this.tags,
    required this.owner,
    required this.hideMembers,
    required this.hideAbout,
    required this.hideActivities,
    required this.hideFollowers,
    required this.indexUrl,
    required this.indexGuestUrl,
    required this.profileImage,
    required this.coverImage,
    required this.membersCount,
    required this.lastMemberships,
  });

  factory Space.empty() {
    return Space(
      id: 0,
      guid: '',
      name: '',
      description: '',
      url: '',
      contentContainerId: 0,
      visibility: 0,
      joinPolicy: 0,
      status: 0,
      tags: [],
      owner: Owner.empty(),
      hideMembers: 0,
      hideAbout: 0,
      hideActivities: 0,
      hideFollowers: 0,
      indexUrl: '',
      indexGuestUrl: '',
      profileImage: '',
      coverImage: '',
      membersCount: 0,
      lastMemberships: [],
    );
  }

  factory Space.fromJson(Map<String, dynamic> json) {
    return Space(
      id: json['id'],
      guid: json['guid'],
      name: json['name'],
      description: json['description'] ?? '',
      url: json['url'],
      contentContainerId: json['contentcontainer_id'],
      visibility: json['visibility'],
      joinPolicy: json['join_policy'],
      status: json['status'],
      tags: List<String>.from(json['tags'] ?? []),
      owner: Owner.fromJson(json['owner']),
      hideMembers: json['hideMembers'],
      hideAbout: json['hideAbout'],
      hideActivities: json['hideActivities'],
      hideFollowers: json['hideFollowers'],
      indexUrl: json['indexUrl'] ?? '',
      indexGuestUrl: json['indexGuestUrl'] ?? '',
      profileImage: json['profile_image'] ?? '',
      coverImage: json['cover_image'] ?? '',
      membersCount: json['members_count'] ?? 0,
      lastMemberships: json['last_memberships'] != null
          ? List<MembershipInfo>.from(
              json['last_memberships'].map((m) => MembershipInfo.fromJson(m)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'name': name,
      'description': description,
      'url': url,
      'contentcontainer_id': contentContainerId,
      'visibility': visibility,
      'join_policy': joinPolicy,
      'status': status,
      'tags': tags,
      'owner': owner.toJson(),
      'hideMembers': hideMembers,
      'hideAbout': hideAbout,
      'hideActivities': hideActivities,
      'hideFollowers': hideFollowers,
      'indexUrl': indexUrl,
      'indexGuestUrl': indexGuestUrl,
      'profile_image': profileImage,
      'cover_image': coverImage,
      'members_count': membersCount,
      'last_memberships': lastMemberships.map((m) => m.toJson()).toList(),
    };
  }
}
