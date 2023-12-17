import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readitique_mobile/models/userprofile.dart';

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(
        userProfile: UserProfile(
          model: Model.RPROFILE_USERPROFILE,
          pk: 1,
          fields: Fields(
            user: 123, // Replace with actual user ID
            handphone: 1234567890,
            email: 'user@example.com', // Replace with actual email
            favoriteBooks: [1, 2, 3], // Replace with actual book IDs
          ),
        ),
      ),
    );
  }
}