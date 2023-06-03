import 'package:flutter/material.dart';
import 'package:responsi_tpm/models/moviemodel.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<MovieModel> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final db = await DatabaseHelper.instance.database;
    final movies = await db.query(DatabaseHelper.tableName);
    setState(() {
      favoriteMovies = movies.map((json) => Movie.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.year),
          );
        },
      ),
    );
  }
}
