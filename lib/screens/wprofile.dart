import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class WProfilePage extends StatefulWidget {
  final String username;

  WProfilePage({required this.username});

  @override
  State<WProfilePage> createState() => _WProfilePageState();
}

class _WProfilePageState extends State<WProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 30.0, right: 30.0, left: 30.0),
        child: Column(
          children: [
          

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
                        minLines: 7,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: "Username",
                          labelText: "Update Your Username",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _username = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty!";
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
              "http://127.0.0.1:8000/profile/${widget.username}/create-flutter/",
              jsonEncode(<String, String>{'username': _username}),
            );
            if (response['status'] == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Username has been saved!'),
              ));
              _formKey.currentState!.reset();
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("An error occurred, please try again."),
              ));
            }
          }
        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
