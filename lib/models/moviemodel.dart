class MovieModel {
  final String title;
  final String year;

  MovieModel({required this.title, required this.year});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['Title'],
      year: json['Year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
    };
  }
}
