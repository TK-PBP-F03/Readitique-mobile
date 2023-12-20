import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class WProfilePage extends StatefulWidget {
  final String user;

  WProfilePage({required this.user});

  @override
  State<WProfilePage> createState() => _WProfilePageState();
}

class _WProfilePageState extends State<WProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
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
                          hintText: "User",
                          labelText: "Update Your email",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _email = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "User cannot be empty!";
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
              "https://readitique.my.id/profile/create-flutter/${widget.user}/",
              jsonEncode(<String, String>{'email': _email}),
            );
            if (response['status'] == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Email has been saved!'),
              ));
              _formKey.currentState!.reset();
              print("berhasil");
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
