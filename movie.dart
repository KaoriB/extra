class Movie {
  final String title;
  final String year;

  Movie({required this.title, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      year: json['year'],
    );
  }
}
