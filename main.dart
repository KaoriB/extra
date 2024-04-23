import 'package:flutter/material.dart';
import 'movie_list.dart'; // Importa el archivo movie_list.dart donde se encuentra la pantalla MovieList

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieList(), // Configura MovieList como la pantalla principal
    );
  }
}
