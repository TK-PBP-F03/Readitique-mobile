import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readitique_mobile/models/userprofile.dart';

class UserProfileService {
  static Future<List<UserProfile>> fetchUserProfiles() async {
    final response = await http
        .get(Uri.parse("https://readitique.my.id/api/user_profiles/"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<UserProfile> userProfiles =
          data.map((profile) => UserProfile.fromJson(profile)).toList();
      return userProfiles;
    } else {
      throw Exception('Failed to load user profiles');
    }
  }
}
