class UserInfo {
  final int id;
  final String guid;
  final String displayName;
  final String url;
  final String imageUrl;
  final String imageUrlOrg;
  final String bannerUrl;
  final String bannerUrlOrg;

  UserInfo({
    required this.id,
    required this.guid,
    required this.displayName,
    required this.url,
    required this.imageUrl,
    required this.imageUrlOrg,
    required this.bannerUrl,
    required this.bannerUrlOrg,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      guid: json['guid'],
      displayName: json['display_name'],
      url: json['url'],
      imageUrl: json['image_url'],
      imageUrlOrg: json['image_url_org'],
      bannerUrl: json['banner_url'],
      bannerUrlOrg: json['banner_url_org'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'display_name': displayName,
      'url': url,
      'image_url': imageUrl,
      'image_url_org': imageUrlOrg,
      'banner_url': bannerUrl,
      'banner_url_org': bannerUrlOrg,
    };
  }
}