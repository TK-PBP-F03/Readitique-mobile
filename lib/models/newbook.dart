import 'dart:convert';

List<NewBook> newBookFromJson(String str) =>
    List<NewBook>.from(json.decode(str).map((x) => NewBook.fromJson(x)));

String newBookToJson(List<NewBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewBook {
  String model;
  int pk;
  Fields fields;

  NewBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory NewBook.fromJson(Map<String, dynamic> json) => NewBook(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int indexKey;
  String title;
  String author;
  String description;
  String genre;
  int rating;
  String imageLink;
  int countRead;
  int votes;

  Fields({
    required this.indexKey,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.rating,
    required this.imageLink,
    required this.countRead,
    required this.votes,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        indexKey: json["index_key"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        genre: json["genre"],
        rating: json["rating"],
        imageLink: json["image_link"],
        countRead: json["count_read"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "index_key": indexKey,
        "title": title,
        "author": author,
        "description": description,
        "genre": genre,
        "rating": rating,
        "image_link": imageLink,
        "count_read": countRead,
        "votes": votes,
      };
}
