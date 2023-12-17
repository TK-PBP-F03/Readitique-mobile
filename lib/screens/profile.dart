import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  UserProfileScreen({required this.userProfile});

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
            Text('ID: ${userProfile.id}'),
            SizedBox(height: 8),
            Text('Handphone: ${userProfile.handphone}'),
            SizedBox(height: 8),
            Text('Email: ${userProfile.email}'),
            // Add other fields as needed
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  final int id;
  final String handphone;
  final String email;

  UserProfile({required this.id, required this.handphone, required this.email});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(
        userProfile: UserProfile(
          id: 1, // Replace with actual user ID
          handphone: '1234567890', // Replace with actual handphone
          email: 'user@example.com', // Replace with actual email
        ),
      ),
    );
  }
}
