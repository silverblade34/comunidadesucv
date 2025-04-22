class Owner {
  final int id;
  final String guid;
  final String displayName;
  final String url;

  Owner({
    required this.id,
    required this.guid,
    required this.displayName,
    required this.url,
  });

  factory Owner.empty() {
    return Owner(
      id: 0,
      guid: '',
      displayName: '',
      url: '',
    );
  }

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      guid: json['guid'],
      displayName: json['display_name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'guid': guid,
      'display_name': displayName,
      'url': url,
    };
  }
}
