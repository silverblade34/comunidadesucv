// To parse this JSON data, do
//
//     final questionResponseDto = questionResponseDtoFromJson(jsonString);

import 'dart:convert';

QuestionResponseDto questionResponseDtoFromJson(String str) => QuestionResponseDto.fromJson(json.decode(str));

String questionResponseDtoToJson(QuestionResponseDto data) => json.encode(data.toJson());

class QuestionResponseDto {
    int code;
    String message;
    int id;
    String question;
    String description;
    CreatedBy createdBy;
    dynamic bestAnswer;
    List<dynamic> lastAnswers;
    Likes likes;
    Comments comments;

    QuestionResponseDto({
        required this.code,
        required this.message,
        required this.id,
        required this.question,
        required this.description,
        required this.createdBy,
        required this.bestAnswer,
        required this.lastAnswers,
        required this.likes,
        required this.comments,
    });

    factory QuestionResponseDto.fromJson(Map<String, dynamic> json) => QuestionResponseDto(
        code: json["code"],
        message: json["message"],
        id: json["id"],
        question: json["question"],
        description: json["description"],
        createdBy: CreatedBy.fromJson(json["created_by"]),
        bestAnswer: json["best_answer"],
        lastAnswers: List<dynamic>.from(json["last_answers"].map((x) => x)),
        likes: Likes.fromJson(json["likes"]),
        comments: Comments.fromJson(json["comments"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "id": id,
        "question": question,
        "description": description,
        "created_by": createdBy.toJson(),
        "best_answer": bestAnswer,
        "last_answers": List<dynamic>.from(lastAnswers.map((x) => x)),
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
