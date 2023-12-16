import 'package:flutter/material.dart';
import 'package:readitique_mobile/models/book.dart' as book;
import 'package:readitique_mobile/models/bookReview.dart';
import 'package:readitique_mobile/screens/wreview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpringBook extends StatefulWidget {
  final book.Fields bookFields;

  SpringBook({required this.bookFields});

  @override
  _SpringBookState createState() => _SpringBookState();
}

class _SpringBookState extends State<SpringBook> {
  Future<List<BookReview>> fetchReview() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/reviews/${widget.bookFields.indexKey}/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<BookReview> reviews = [];
    for (var d in data) {
      if (d != null) {
        reviews.add(BookReview.fromJson(d));
      }
    }
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<BookReview>>(
                      future: fetchReview(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text("No reviews found."));
                        } else {
                          // Now we have data
                          List<BookReview> reviews = snapshot.data!;

                          return ListView.builder(
                            itemCount: reviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Flutter User ${reviews[index].fields.user}", // You might want to replace this with actual user data
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        reviews[index]
                                            .fields
                                            .review, // Replace with actual field name
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 54.0),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add code to navigate to Add Review Screen
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WriteReviewPage(
                        bookFields: widget.bookFields,
                      )));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Add Review"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
