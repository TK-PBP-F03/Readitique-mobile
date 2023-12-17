import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfileService {
  final String baseUrl;

  UserProfileService({required this.baseUrl});

  Future<UserProfile> getUserProfile(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/user_profiles/$userId/'));

    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }
}

class UserProfile {
  final int id;
  final String handphone;
  final String email;
  // Add other fields as needed

  UserProfile({required this.id, required this.handphone, required this.email});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      handphone: json['handphone'],
      email: json['email'],
      // Add other fields as needed
    );
  }
}
