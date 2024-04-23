import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart'; // Asegúrate de tener el archivo movie.dart con la clase Movie
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late List<Movie> movies = [];
  late GlobalKey<AnimatedListState> moviesListKey;

  @override
  void initState() {
    super.initState();
    moviesListKey = GlobalKey<AnimatedListState>();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response =
          await http.get(Uri.parse('https://stapi.co/api/v1/rest/movie/list'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          movies = (jsonData['movies'] as List)
              .map((movie) => Movie.fromJson(movie))
              .toList();
        });
        print('Movies loaded: $movies');
      } else {
        throw Exception(
            'Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              key: moviesListKey,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.year),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetail(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
