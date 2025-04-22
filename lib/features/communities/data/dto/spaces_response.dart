import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';

class SpacesResponse {
  final int total;
  final int page;
  final int pages;
  final Map<String, String> links;
  final List<Space> results;

  SpacesResponse({
    required this.total,
    required this.page,
    required this.pages,
    required this.links,
    required this.results,
  });

  factory SpacesResponse.fromJson(Map<String, dynamic> json) {
    return SpacesResponse(
      total: json['total'],
      page: json['page'],
      pages: json['pages'],
      links: Map<String, String>.from(json['links']),
      results: (json['results'] as List)
          .map((space) => Space.fromJson(space))
          .toList(),
    );
  }
}
