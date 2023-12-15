import 'package:flutter/material.dart';
import 'package:readitique_mobile/homepage/book_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readitique',
      debugShowCheckedModeBanner: false,
      home: Bookstore(),
    );
  }
}