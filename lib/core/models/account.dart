class Account {
  int id;
  String? guid;
  String username;
  String? email;
  int visibility;
  int status;
  List<String> tags;
  String? language;
  String? timeZone;
  int contentcontainerId;
  String? authclient;
  dynamic authclientId;
  String? lastLogin;

  Account({
    required this.id,
    this.guid,
    required this.username,
    this.email,
    required this.visibility,
    required this.status,
    required this.tags,
    this.language,
    this.timeZone,
    required this.contentcontainerId,
    this.authclient,
    this.authclientId,
    this.lastLogin,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"] ?? 0,
        guid: json["guid"],
        username: json["username"],
        email: json["email"],
        visibility: json["visibility"] ?? 0,
        status: json["status"] ?? 0,
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
        language: json["language"],
        timeZone: json["time_zone"],
        contentcontainerId: json["contentcontainer_id"] ?? 0,
        authclient: json["authclient"],
        authclientId: json["authclient_id"],
        lastLogin: json["last_login"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "username": username,
        "email": email,
        "visibility": visibility,
        "status": status,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "language": language,
        "time_zone": timeZone,
        "contentcontainer_id": contentcontainerId,
        "authclient": authclient,
        "authclient_id": authclientId,
        "last_login": lastLogin,
      };
}
