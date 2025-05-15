// To parse this JSON data, do
//
//     final questionSpaceDto = questionSpaceDtoFromJson(jsonString);

import 'dart:convert';

import 'package:comunidadesucv/core/models/question.dart';

QuestionSpaceDto questionSpaceDtoFromJson(String str) => QuestionSpaceDto.fromJson(json.decode(str));

String questionSpaceDtoToJson(QuestionSpaceDto data) => json.encode(data.toJson());

class QuestionSpaceDto {
    int total;
    int page;
    int pages;
    Links links;
    List<Question> results;

    QuestionSpaceDto({
        required this.total,
        required this.page,
        required this.pages,
        required this.links,
        required this.results,
    });

    factory QuestionSpaceDto.fromJson(Map<String, dynamic> json) => QuestionSpaceDto(
        total: json["total"],
        page: json["page"],
        pages: json["pages"],
        links: Links.fromJson(json["links"]),
        results: List<Question>.from(json["results"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pages": pages,
        "links": links.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Links {
    String self;
    String first;
    String last;

    Links({
        required this.self,
        required this.first,
        required this.last,
    });

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        first: json["first"],
        last: json["last"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "last": last,
    };
}
