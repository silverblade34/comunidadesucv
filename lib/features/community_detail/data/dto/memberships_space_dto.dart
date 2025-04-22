import 'package:comunidadesucv/core/models/links.dart';
import 'package:comunidadesucv/features/communities/data/dto/membership_info.dart';

class MembershipsSpaceDto {
  final int total;
  final int page;
  final int pages;
  final Links links;
  final List<MembershipInfo> results;

  MembershipsSpaceDto({
    required this.total,
    required this.page,
    required this.pages,
    required this.links,
    required this.results,
  });

  factory MembershipsSpaceDto.fromJson(Map<String, dynamic> json) {
    return MembershipsSpaceDto(
      total: json['total'],
      page: json['page'],
      pages: json['pages'],
      links: Links.fromJson(json['links']),
      results: (json['results'] as List)
          .map((postJson) => MembershipInfo.fromJson(postJson))
          .toList(),
    );
  }
}