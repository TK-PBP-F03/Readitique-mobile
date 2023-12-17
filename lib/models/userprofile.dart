
// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
    Model model;
    int pk;
    Fieldsm fields;

    UserProfile({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fieldsm.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fieldsm {
    int user;
    int? handphone;
    String email;
    List<int> favoriteBooks;

    Fieldsm({
        required this.user,
        required this.handphone,
        required this.email,
        required this.favoriteBooks,
    });

    factory Fieldsm.fromJson(Map<String, dynamic> json) => Fieldsm(
        user: json["user"],
        handphone: json["handphone"],
        email: json["email"],
        favoriteBooks: List<int>.from(json["favorite_books"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "handphone": handphone,
        "email": email,
        "favorite_books": List<dynamic>.from(favoriteBooks.map((x) => x)),
    };
}

enum Model {
    RPROFILE_USERPROFILE
}

final modelValues = EnumValues({
    "rprofile.userprofile": Model.RPROFILE_USERPROFILE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
