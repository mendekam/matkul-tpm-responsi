import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/moviemodel.dart';

class MovieDetailPage extends StatefulWidget {
  final String title;

  MovieDetailPage({required this.title});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  Map<String, dynamic> movieDetails = {};

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    final apiKey = 'e8322197';
    final apiUrl = 'https://www.omdbapi.com/?t=${widget.title}&apikey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        movieDetails = data;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> addToFavorites() async {
    final title = movieDetails['Title'];
    final year = movieDetails['Year'];
    final movie = MovieModel(title: title, year: year);

    final db = await DatabaseHelper.instance.database;
    await db.insert(DatabaseHelper.tableName, movie.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to Favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: addToFavorites,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${movieDetails['Title'] ?? 'Loading...'}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Year: ${movieDetails['Year'] ?? 'Loading...'}',
            ),
            SizedBox(height: 10.0),
            Text(
              'Plot: ${movieDetails['Plot'] ?? 'Loading...'}',
            ),
          ],
        ),
      ),
    );
  }
}
