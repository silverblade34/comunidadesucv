import 'package:comunidadesucv/core/models/account.dart';
import 'package:comunidadesucv/core/models/profile.dart';
import 'package:comunidadesucv/core/models/space_summary.dart';

class UserDetail {
  int id;
  String? guid;
  String? displayName;
  String? url;
  Account? account;
  Profile? profile;
  List<SpaceSummary> spaces;

  UserDetail({
    required this.id,
    this.guid,
    this.displayName,
    this.url,
    this.account,
    this.profile,
    required this.spaces,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"] ?? 0,
        guid: json["guid"],
        displayName: json["display_name"],
        url: json["url"],
        account:
            json["account"] != null ? Account.fromJson(json["account"]) : null,
        profile:
            json["profile"] != null ? Profile.fromJson(json["profile"]) : null,
        spaces: json["spaces"] != null
            ? List<SpaceSummary>.from(
                json["spaces"].map((x) => SpaceSummary.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "display_name": displayName,
        "url": url,
        "account": account?.toJson(),
        "profile": profile?.toJson(),
        "spaces": List<dynamic>.from(spaces.map((x) => x.toJson())),
      };

  factory UserDetail.empty() => UserDetail(
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
        spaces: [],
      );
}
