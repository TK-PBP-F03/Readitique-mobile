import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:readitique_mobile/addBuku/addbuku_form.dart';
import 'package:readitique_mobile/addbuku/newbook_details.dart';
import 'dart:convert';
import 'package:readitique_mobile/models/newbook.dart';

class AddBukuPage extends StatefulWidget {
  final String username;
  const AddBukuPage({required this.username});
  //const AddBukuPage({Key? key}) : super(key: key);

  @override
  _AddBukuPageState createState() => _AddBukuPageState(username:username);
}

class _AddBukuPageState extends State<AddBukuPage> {
  final String username;
  _AddBukuPageState({required this.username});
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
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Suggestions',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900
          ),)
          ,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewBookFormPage(username:username)),
                    );
                  },
                  child: const Text("Suggest a book"),
                ),
              ),
              FutureBuilder(
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
                      return 
                      Container(
                        height: double.maxFinite,
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
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
                                    horizontal: 16, vertical: 20),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                      ),
                                      width: 80,
                                      height: 120,
                                      child: Image.network(
                                        snapshot.data![index].fields.imageLink,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )),
                                      const SizedBox(height: 10),
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
                                    ElevatedButton(
                                      onPressed: () async {
                                        final response = await request.postJson(
                                          "http://127.0.0.1:8000/add-buku/vote-flutter/",
                                          jsonEncode(<String, int>{
                                            'id': snapshot.data![index].pk
                                          }));
                                          if (response['status'] == 'success') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text("Voting success!"),
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Voting failed."),
                                            ));
                                          }
                                          setState(() {
                                          snapshot.data![index].fields.votes++;
                                          });
                                          },
                                    child: Text(
                                  "${snapshot.data![index].fields.votes} Votes",
                                ),
                                    ),
                                  ],
                                ),
                              )
                        )
                      ),
                      );
                    }
                  }
                }
              )
            ],
          ),
        )
    );
  }
}