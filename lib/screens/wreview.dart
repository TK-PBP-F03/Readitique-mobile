import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readitique_mobile/screens/reviews.dart';
import 'package:readitique_mobile/models/book.dart' as book;
import 'package:http/http.dart' as http;
import 'dart:convert';

class WriteReviewPage extends StatefulWidget {
  final book.Fields bookFields;

  WriteReviewPage({required this.bookFields});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  final _formKey = GlobalKey<FormState>();
  String _review = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookFields.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 30.0, right: 30.0, left: 30.0),
        child: Column(
          children: [
            SizedBox(
              // container image title dan deskripsi
              height: 300,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the radius for the curve
                    child: Image.network(
                      widget.bookFields.imageLink,
                      // Add other image properties if needed
                    ),
                  ),
                  Expanded(
                    // Wrap the Column in an Expanded widget
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SingleChildScrollView(
                        // Make the Column scrollable
                        scrollDirection:
                            Axis.vertical, // Enable vertical scrolling
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.bookFields.description),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        minLines: 7, // A minimum of 10 lines
                        maxLines: 7, // max line of 10
                        decoration: InputDecoration(
                          hintText: "Review",
                          labelText: "Write Your Review",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _review = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Review tidak boleh kosong!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final response = await request.postJson(
                  "http://127.0.0.1:8000/reviews/${widget.bookFields.indexKey}/create-flutter/",
                  jsonEncode(<String, String>{'review': _review}));
              if (response['status'] == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Review telah disimpan!'),
                ));
                _formKey.currentState!.reset();
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Terdapat kesalahan, silakan coba lagi."),
                ));
              }
            }
          },
          icon: const Icon(Icons.save),
          label: const Text("Save")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
