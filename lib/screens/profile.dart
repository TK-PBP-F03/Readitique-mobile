import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readitique_mobile/models/userprofile.dart';
import 'package:http/http.dart' as http;

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
            Text('Username: ${userProfile.fields.user}'),
            SizedBox(height: 8),
            Text('Handphone: ${userProfile.fields.handphone ?? "Not provided"}'),
            SizedBox(height: 8),
            Text('Email: ${userProfile.fields.email}'),
            SizedBox(height: 8),
            Text('Favorite Books: ${userProfile.fields.favoriteBooks.join(", ")}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showMessage(context);
              },
              child: Text('Show Message'),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Button Tapped!'),
          content: Text('You tapped the button!'),
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
  final String username;

  ProfileApp({required this.username});

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  Future<UserProfile> fetchUserProfile() async {
    var url =
        Uri.parse('http://127.0.0.1:8000/profile/${widget.username}/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data.isNotEmpty) {
      return UserProfile.fromJson(data[0]);
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
            return ProfileScreen(userProfile: snapshot.data!);
          }
        },
      ),
    );
  }
}

