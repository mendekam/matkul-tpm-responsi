import 'package:flutter/material.dart';
import 'package:responsi_tpm/models/moviemodel.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);
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
      favoriteMovies = movies.map((json) => MovieModel.fromJson(json)).toList();
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
