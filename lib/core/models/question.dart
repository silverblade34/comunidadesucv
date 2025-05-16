// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  int id;
  String question;
  String description;
  AtedBy createdBy;
  dynamic bestAnswer;
  List<dynamic> lastAnswers;
  int answerCount;
  Content content;

  Question({
    required this.id,
    required this.question,
    required this.description,
    required this.createdBy,
    required this.bestAnswer,
    required this.lastAnswers,
    required this.answerCount,
    required this.content,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        description: json["description"],
        createdBy: AtedBy.fromJson(json["created_by"]),
        bestAnswer: json["best_answer"],
        lastAnswers: List<dynamic>.from(json["last_answers"].map((x) => x)),
        answerCount: json["answer_count"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "description": description,
        "created_by": createdBy.toJson(),
        "best_answer": bestAnswer,
        "last_answers": List<dynamic>.from(lastAnswers.map((x) => x)),
        "answer_count": answerCount,
        "content": content.toJson(),
      };
}

class Content {
  int id;
  Metadata metadata;
  Comments comments;
  Likes likes;
  List<dynamic> topics;
  List<FileElement> files;
  bool userLiked;

  Content({
    required this.id,
    required this.metadata,
    required this.comments,
    required this.likes,
    required this.topics,
    required this.files,
    required this.userLiked,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        metadata: Metadata.fromJson(json["metadata"]),
        comments: Comments.fromJson(json["comments"]),
        likes: Likes.fromJson(json["likes"]),
        topics: List<dynamic>.from(json["topics"].map((x) => x)),
        files: List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
        userLiked: json["user_liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "metadata": metadata.toJson(),
        "comments": comments.toJson(),
        "likes": likes.toJson(),
        "topics": List<dynamic>.from(topics.map((x) => x)),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "user_liked": userLiked,
      };
}

class Comments {
  int total;
  List<dynamic> latest;

  Comments({
    required this.total,
    required this.latest,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        total: json["total"],
        latest: List<dynamic>.from(json["latest"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "latest": List<dynamic>.from(latest.map((x) => x)),
      };
}

class FileElement {
  int id;
  String guid;
  String mimeType;
  String size;
  String fileName;
  String url;

  FileElement({
    required this.id,
    required this.guid,
    required this.mimeType,
    required this.size,
    required this.fileName,
    required this.url,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        guid: json["guid"],
        mimeType: json["mime_type"],
        size: json["size"],
        fileName: json["file_name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "mime_type": mimeType,
        "size": size,
        "file_name": fileName,
        "url": url,
      };
}

class Likes {
  int total;

  Likes({
    required this.total,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}

class Metadata {
  int id;
  String guid;
  String objectModel;
  int objectId;
  int visibility;
  int state;
  bool archived;
  bool hidden;
  bool pinned;
  bool lockedComments;
  AtedBy createdBy;
  DateTime createdAt;
  AtedBy updatedBy;
  DateTime updatedAt;
  dynamic scheduledAt;
  String url;
  int contentcontainerId;
  String streamChannel;

  Metadata({
    required this.id,
    required this.guid,
    required this.objectModel,
    required this.objectId,
    required this.visibility,
    required this.state,
    required this.archived,
    required this.hidden,
    required this.pinned,
    required this.lockedComments,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.scheduledAt,
    required this.url,
    required this.contentcontainerId,
    required this.streamChannel,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json["id"],
        guid: json["guid"],
        objectModel: json["object_model"],
        objectId: json["object_id"],
        visibility: json["visibility"],
        state: json["state"],
        archived: json["archived"],
        hidden: json["hidden"],
        pinned: json["pinned"],
        lockedComments: json["locked_comments"],
        createdBy: AtedBy.fromJson(json["created_by"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedBy: AtedBy.fromJson(json["updated_by"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        scheduledAt: json["scheduled_at"],
        url: json["url"],
        contentcontainerId: json["contentcontainer_id"],
        streamChannel: json["stream_channel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "object_model": objectModel,
        "object_id": objectId,
        "visibility": visibility,
        "state": state,
        "archived": archived,
        "hidden": hidden,
        "pinned": pinned,
        "locked_comments": lockedComments,
        "created_by": createdBy.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_by": updatedBy.toJson(),
        "updated_at": updatedAt.toIso8601String(),
        "scheduled_at": scheduledAt,
        "url": url,
        "contentcontainer_id": contentcontainerId,
        "stream_channel": streamChannel,
      };
}

class AtedBy {
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
  String codigo;

  AtedBy({
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
    required this.codigo,
  });

  factory AtedBy.fromJson(Map<String, dynamic> json) => AtedBy(
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
        codigo: json["codigo"],
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
        "codigo": codigo,
      };
}
