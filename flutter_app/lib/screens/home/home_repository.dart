import 'package:flutter_app/models/movie.dart';
import 'package:flutter_app/network/api/movie_api.dart';

class MovieRepository {
  MovieApi _movieApi = MovieApi();

  Future<MovieResponse> getMovies() {
    return _movieApi.getMovies();
  }
}
