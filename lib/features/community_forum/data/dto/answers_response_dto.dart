// To parse this JSON data, do
//
//     final answersResponseDto = answersResponseDtoFromJson(jsonString);

import 'dart:convert';

AnswersResponseDto answersResponseDtoFromJson(String str) => AnswersResponseDto.fromJson(json.decode(str));

String answersResponseDtoToJson(AnswersResponseDto data) => json.encode(data.toJson());

class AnswersResponseDto {
    int code;
    String message;
    List<Answer> answers;

    AnswersResponseDto({
        required this.code,
        required this.message,
        required this.answers,
    });

    factory AnswersResponseDto.fromJson(Map<String, dynamic> json) => AnswersResponseDto(
        code: json["code"],
        message: json["message"],
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    };
}

class Answer {
    int id;
    String answer;
    int votesSummary;
    CreatedBy createdBy;
    Likes likes;
    Comments comments;

    Answer({
        required this.id,
        required this.answer,
        required this.votesSummary,
        required this.createdBy,
        required this.likes,
        required this.comments,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
        votesSummary: json["votes_summary"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        likes: Likes.fromJson(json["likes"]),
        comments: Comments.fromJson(json["comments"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "votes_summary": votesSummary,
        "created_by": createdBy.toJson(),
        "likes": likes.toJson(),
        "comments": comments.toJson(),
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

class CreatedBy {
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

    CreatedBy({
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

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
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
