import 'package:comunidadesucv/core/models/comment_status.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';

class PendingComment {
  final String id;
  final int postId;
  final String message;
  CommentStatus status;
  final CreatedBy createdBy;
  final String createdAt;

  PendingComment({
    required this.id,
    required this.postId,
    required this.message,
    required this.status,
    required this.createdBy,
    required this.createdAt,
  });
}
