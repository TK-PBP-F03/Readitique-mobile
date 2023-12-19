import 'package:flutter/material.dart';
import 'package:readitique_mobile/models/book.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readitique_mobile/screens/constant.dart';
import 'package:readitique_mobile/screens/book_detail.dart';
import 'package:readitique_mobile/screens/profile.dart';
import 'package:readitique_mobile/addbuku/addbuku.dart';

class NavigationItem {
  IconData iconData;
  String title; // Add a title property for identification
  NavigationItem(this.iconData, this.title);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home, "home"),
    NavigationItem(Icons.book, "book"),
    NavigationItem(Icons.person, "profile"),
  ];
}

class Filter {
  String name;
  String value;

  Filter(this.name, this.value);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("All", ""),
  ];
}

class Bookstore extends StatefulWidget {
  final String username;
  Bookstore({required this.username});
  @override
  _BookstoreState createState() => _BookstoreState(username: username);
}

class _BookstoreState extends State<Bookstore> {
  final String username;
  _BookstoreState({required this.username});

  late List<Filter> filters;
  late Filter selectedFilter;

  late List<Fields> filteredBooks = [];

  late List<NavigationItem> navigationItems;
  late NavigationItem selectedItem;

  late Future<List<Fields>> books;

  @override
  void initState() {
    super.initState();
    filters = getFilterList();
    selectedFilter = filters[0];

    filteredBooks = [];

    navigationItems = getNavigationItemList();
    selectedItem = navigationItems[0];

    books = fetchBooks(selectedFilter.value);
  }

  void filterBooks(String query) {
    setState(() {
      if (query.isEmpty && selectedFilter.value.isEmpty) {
        filteredBooks = []; // Reset filter when both query and genre are empty
      } else {
        // Wait for the books future to complete
        books.then((List<Fields>? allBooks) {
          if (selectedFilter.value.isEmpty) {
            // If genre is empty, apply only the search query filter
            filteredBooks = allBooks
                    ?.where((book) =>
                        book.title
                            .toLowerCase()
                            .contains(query.toLowerCase()) ||
                        book.author.toLowerCase().contains(query.toLowerCase()))
                    .toList() ??
                [];
          } else {
            // If genre is not empty, apply both genre and search query filters
            filteredBooks = allBooks
                    ?.where((book) =>
                        book.genre.toLowerCase() ==
                            selectedFilter.value.toLowerCase() &&
                        (book.title
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            book.author
                                .toLowerCase()
                                .contains(query.toLowerCase())))
                    .toList() ??
                [];
          }
        });
      }
    });
  }

  Future<List<Fields>> fetchBooks(String genre) async {
    String url = 'http://127.0.0.1:8000/api/books/';
    if (genre.isNotEmpty) {
      url += '?genre=$genre';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Fields.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Widget buildBooks(List<Fields> books) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final String title = books[index].title;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetail(
                  books: books[index],
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
                right: 32, left: index == 0 ? 16 : 0, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 8,
                          blurRadius: 12,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(
                      bottom: 16,
                      top: 24,
                    ),
                    child: Hero(
                      tag: books[index].title,
                      child: Image.network(
                        books[index].imageLink,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Text(
                  title.length <= 40 ? title : title.substring(0, 40) + '...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  books[index].author,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.sort,
          color: kPrimaryColor,
          size: 28,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.search,
              color: Colors.grey[400],
              size: 28,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              width: 200, // Adjust the width as needed
              child: TextField(
                onChanged: (query) => filterBooks(query),
                style: TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: buildMainWidget(),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 8,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
    );
  }

  Widget buildMainWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 7, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 8,
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Readitique",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Expanded(
          child: Card(
            child: FutureBuilder(
              future: books,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Fields> books = snapshot.data as List<Fields>;
                  return buildBooks(
                      filteredBooks.isNotEmpty ? filteredBooks : books);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });

        // Check if the selected item is the one corresponding to the profile page
        if (item.title == "book") {
          // Navigate to AddBukuPage if book icon tapped
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBukuPage(username:username)));
        } else if (item.title == "profile") {
          // Navigate to the ProfileApp
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileApp(user: username),
            ),
          );
        }
      },
      child: Container(
        width: 50,
        child: Center(
          child: Icon(
            item.iconData,
            color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
            size: 28,
          ),
        ),
      ),
    );
  }
}
