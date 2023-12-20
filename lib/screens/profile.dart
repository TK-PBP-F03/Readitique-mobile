import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readitique_mobile/main.dart';
import 'package:readitique_mobile/models/userprofile.dart';
import 'package:readitique_mobile/screens/wprofile.dart';
import "package:readitique_mobile/homepage/book_list.dart";

class LogoutHandler {
  static Future<void> logout(BuildContext context) async {
    var url = Uri.parse('https://readitique.my.id/auth/logout/');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // Successfully logged out, navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
      );
    } else {
      // Handle logout failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout Failed'),
            content: Text('Unable to logout. Please try again.'),
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
}

class ProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  ProfileScreen({required this.userProfile}) {
    usernameNew = "kevin123";
    userNew = userProfile.username!;
  }

  late String usernameNew;
  late String userNew;

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

  void _logout(BuildContext context) {
    LogoutHandler.logout(context);
  }

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
            Text('Username: ${userProfile.username}'),
            SizedBox(height: 8),
            Text('Handphone: ${userProfile.handphone ?? "Not provided"}'),
            SizedBox(height: 8),
            Text('Email: ${userProfile.email}'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _showMessage(context);
              },
              child: Text('Show Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Bookstore(username: userNew),
                  ),
                );
              },
              child: Text('Go to BookStore'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WProfilePage(
                user: userProfile.username.toString(),
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
}

class ProfileApp extends StatefulWidget {
  final String user;

  ProfileApp({required this.user});

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  Future<UserProfile> fetchUserProfile() async {
    var url =
        Uri.parse('https://readitique.my.id/profile/json/${widget.user}/');
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

void main() {
  runApp(ProfileApp(user: "iniadminke2"));
}
