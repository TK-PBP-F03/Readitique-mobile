import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readitique_mobile/models/userprofile.dart';
import 'package:readitique_mobile/screens/wprofile.dart';
import 'package:http/http.dart' as http;

import "package:readitique_mobile/homepage/book_list.dart";

void main() {
  runApp(ProfileApp(user: "iniadminke2"));
}

class ProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  ProfileScreen({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${userProfile.user}'),
            SizedBox(height: 8),
            Text('Handphone: ${userProfile.handphone ?? "Not provided"}'),
            SizedBox(height: 8),
            Text('Email: ${userProfile.email}'),
            SizedBox(height: 8),
            //Text('Favorite Books: ${userProfile.favoriteBooks != null ? userProfile.favoriteBooks.join(", ") : "N/A"}'),
            // SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                _showMessage(context);
              },
              child: Text('Show Message'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the BookStore page without popping
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bookstore()),
                );
              },
              child: Text('Go to BookStore'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to Profile Form Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WProfilePage(
                user: userProfile.user.toString(),
              ),
            ),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit Profile"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Button Tapped!'),
          content: Text('You tapped the profile button!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileApp extends StatefulWidget {
  final String user;

  ProfileApp({required this.user});

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  Future<UserProfile> fetchUserProfile() async {
    var url = Uri.parse('http://127.0.0.1:8000/profile/json/${widget.user}/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data != null) {
      return UserProfile.fromJson(data);
    } else {
      throw Exception('User profile not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<UserProfile>(
        future: fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            UserProfile userProfile = snapshot.data!;
            return ProfileScreen(userProfile: userProfile);
          }
        },
      ),
    );
  }
}
