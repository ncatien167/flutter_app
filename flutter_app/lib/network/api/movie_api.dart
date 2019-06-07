import 'package:dio/dio.dart';
import 'package:flutter_app/network/config/base_api.dart';
import 'package:flutter_app/models/movie.dart';

class MovieApi extends BaseApi{

  static const String _url = 'search/movie?api_key=ee8cf966d22254270f6faa1948ecf3fc&query={1}';

  Future<MovieResponse> getMovies() async {
    try {
      Response response = await dio.get(_url);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}
