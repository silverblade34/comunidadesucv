import 'package:comunidadesucv/core/models/links.dart';

class ContentSpaceDto {
  final int total;
  final int page;
  final int pages;
  final Links links;
  final List<Post> results;

  ContentSpaceDto({
    required this.total,
    required this.page,
    required this.pages,
    required this.links,
    required this.results,
  });

  factory ContentSpaceDto.fromJson(Map<String, dynamic> json) {
    return ContentSpaceDto(
      total: json['total'],
      page: json['page'],
      pages: json['pages'],
      links: Links.fromJson(json['links']),
      results: (json['results'] as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList(),
    );
  }
}

class Post {
  final int id;
  final String message;
  final Content content;

  Post({
    required this.id,
    required this.message,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      message: json['message'],
      content: Content.fromJson(json['content']),
    );
  }
}

class Content {
  final int id;
  final Metadata metadata;
  final Comments comments;
  final Likes likes;
  final List<dynamic> topics;
  final List<dynamic> files;

  Content({
    required this.id,
    required this.metadata,
    required this.comments,
    required this.likes,
    required this.topics,
    required this.files,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      metadata: Metadata.fromJson(json['metadata']),
      comments: Comments.fromJson(json['comments']),
      likes: Likes.fromJson(json['likes']),
      topics: json['topics'],
      files: json['files'],
    );
  }
}

class Metadata {
  final int id;
  final String guid;
  final String objectModel;
  final int objectId;
  final int visibility;
  final int state;
  final bool archived;
  final bool hidden;
  final bool pinned;
  final bool lockedComments;
  final User createdBy;
  final String createdAt;
  final User updatedBy;
  final String updatedAt;
  final String? scheduledAt;
  final String url;
  final int contentcontainerId;
  final String streamChannel;

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
    this.scheduledAt,
    required this.url,
    required this.contentcontainerId,
    required this.streamChannel,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      id: json['id'],
      guid: json['guid'],
      objectModel: json['object_model'],
      objectId: json['object_id'],
      visibility: json['visibility'],
      state: json['state'],
      archived: json['archived'],
      hidden: json['hidden'],
      pinned: json['pinned'],
      lockedComments: json['locked_comments'],
      createdBy: User.fromJson(json['created_by']),
      createdAt: json['created_at'],
      updatedBy: User.fromJson(json['updated_by']),
      updatedAt: json['updated_at'],
      scheduledAt: json['scheduled_at'],
      url: json['url'],
      contentcontainerId: json['contentcontainer_id'],
      streamChannel: json['stream_channel'],
    );
  }
}

class User {
  final int id;
  final String guid;
  final String displayName;
  final String url;
  final String imageUrl;
  final String imageUrlOrg;
  final String bannerUrl;
  final String bannerUrlOrg;

  User({
    required this.id,
    required this.guid,
    required this.displayName,
    required this.url,
    required this.imageUrl,
    required this.imageUrlOrg,
    required this.bannerUrl,
    required this.bannerUrlOrg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
}

class Comments {
  int total;
  final List<dynamic> latest;

  Comments({
    required this.total,
    required this.latest,
  });

  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      total: json['total'],
      latest: json['latest'],
    );
  }
}

class Likes {
  int total;

  Likes({
    required this.total,
  });

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      total: json['total'],
    );
  }
}
