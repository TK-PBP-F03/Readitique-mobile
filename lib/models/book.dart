// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
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
    double rating;
    String imageLink;
    int countRead;
    int user;

    Fields({
        required this.indexKey,
        required this.title,
        required this.author,
        required this.description,
        required this.genre,
        required this.rating,
        required this.imageLink,
        required this.countRead,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        indexKey: json["index_key"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        genre: json["genre"],
        rating: json["rating"]?.toDouble(),
        imageLink: json["image_link"],
        countRead: json["count_read"],
        user: json["user"],
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
        "user": user,
    };
}
