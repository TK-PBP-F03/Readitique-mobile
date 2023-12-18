import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readitique_mobile/addbuku/newbook_details.dart';
import 'dart:convert';
import 'package:readitique_mobile/models/newbook.dart';

class AddBukuPage extends StatefulWidget {
  const AddBukuPage({Key? key}) : super(key: key);

  @override
  _AddBukuPageState createState() => _AddBukuPageState();
}

class _AddBukuPageState extends State<AddBukuPage> {
  Future<List<NewBook>> fetchNewBook() async {
    var url = Uri.parse('http://127.0.0.1:8000/add-buku/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object NewBook
    List<NewBook> list_NewBook = [];
    for (var d in data) {
      if (d != null) {
        list_NewBook.add(NewBook.fromJson(d));
      }
    }
    return list_NewBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NewBook'),
        ),
        body: FutureBuilder(
            future: fetchNewBook(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data usulan buku baru.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            final newbook = snapshot.data![index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewBookDetails(newBook: newbook)),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.author}"),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.votes}")
                              ],
                            ),
                          )));
                }
              }
            }));
  }
}
