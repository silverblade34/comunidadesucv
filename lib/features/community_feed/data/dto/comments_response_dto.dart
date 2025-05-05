
import 'package:comunidadesucv/core/models/links.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';

class CommentsResponseDto {
  final int total;
  final int page;
  final int pages;
  final Links links;
  final List<CommentItem> results;

  CommentsResponseDto({
    required this.total,
    required this.page,
    required this.pages,
    required this.links,
    required this.results,
  });

  factory CommentsResponseDto.fromJson(Map<String, dynamic> json) {
    return CommentsResponseDto(
      total: json['total'],
      page: json['page'],
      pages: json['pages'],
      links: Links.fromJson(json['links']),
      results: (json['results'] as List)
          .map((postJson) => CommentItem.fromJson(postJson))
          .toList(),
    );
  }
}