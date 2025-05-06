// To parse this JSON data, do
//
//     final userFriendship = userFriendshipFromJson(jsonString);

import 'dart:convert';

UserFriendship userFriendshipFromJson(String str) => UserFriendship.fromJson(json.decode(str));

String userFriendshipToJson(UserFriendship data) => json.encode(data.toJson());

class UserFriendship {
    int id;
    String guid;
    String displayName;
    String url;
    String imageUrl;
    String imageUrlOrg;
    String bannerUrl;
    String bannerUrlOrg;
    List<String> tags;
    String carrera;
    String filial;

    UserFriendship({
        required this.id,
        required this.guid,
        required this.displayName,
        required this.url,
        required this.imageUrl,
        required this.imageUrlOrg,
        required this.bannerUrl,
        required this.bannerUrlOrg,
        required this.tags,
        required this.carrera,
        required this.filial,
    });

    factory UserFriendship.fromJson(Map<String, dynamic> json) => UserFriendship(
        id: json["id"],
        guid: json["guid"],
        displayName: json["display_name"],
        url: json["url"],
        imageUrl: json["image_url"],
        imageUrlOrg: json["image_url_org"],
        bannerUrl: json["banner_url"],
        bannerUrlOrg: json["banner_url_org"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        carrera: json["carrera"],
        filial: json["filial"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "display_name": displayName,
        "url": url,
        "image_url": imageUrl,
        "image_url_org": imageUrlOrg,
        "banner_url": bannerUrl,
        "banner_url_org": bannerUrlOrg,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "carrera": carrera,
        "filial": filial,
    };
}
