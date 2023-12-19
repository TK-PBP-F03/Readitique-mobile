import 'package:flutter/material.dart';
import 'package:readitique_mobile/models/newbook.dart';

class NewBookDetails extends StatelessWidget {
  final NewBook newBook;

  const NewBookDetails({Key? key, required this.newBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${newBook.fields.title} Details',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 200,
                  height: 300,
                  child: Image.network(
                    newBook.fields.imageLink,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 25.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newBook.fields.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Author: ${newBook.fields.author}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Genre: ${newBook.fields.genre}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Votes: ${newBook.fields.votes}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Description: ${newBook.fields.description}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
