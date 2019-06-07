

class MovieResponse {
  final List<MovieModel> movies;
  final String error;

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
      .map((i) => new MovieModel.fromJson(i))
      .toList(),
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;

}

class MovieModel {
  final String title, posterPath, overview;

  MovieModel(this.title, this.posterPath, this.overview);

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = json["poster_path"],
        overview = json["overview"];
}