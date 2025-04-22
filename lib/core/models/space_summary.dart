class SpaceSummary {
  int id;
  String guid;
  String name;
  String description;
  String url;
  String profileImage;
  String coverImage;

  SpaceSummary({
    required this.id,
    required this.guid,
    required this.name,
    required this.description,
    required this.url,
    required this.profileImage,
    required this.coverImage,
  });

  factory SpaceSummary.fromJson(Map<String, dynamic> json) => SpaceSummary(
        id: json["id"],
        guid: json["guid"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "name": name,
        "description": description,
        "url": url,
        "profile_image": profileImage,
        "cover_image": coverImage,
      };
}