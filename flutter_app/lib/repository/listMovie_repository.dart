import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../Models/ListMovie.dart';
import '../appconfigs/Constant.dart';

class MovieDBApi {

  static final String baseUrl = 'api.themoviedb.org';
  final apiKey = 'ee8cf966d22254270f6faa1948ecf3fc';

  Future<List<Movie>> getListMovie(String page) async {

    List<Movie> listMovie = List<Movie>();

    final movieUri = Uri.https(baseUrl, '3/movie/popular', {
      'api_key' : apiKey,
      'page' : page,
    });

    final response = await http.Client().get(movieUri);

    if (response.statusCode == 200) {

      Map dataRes = jsonDecode(response.body);
      var res = new Response.fromJSON(dataRes);

      for (var i = 0; i<res.results.length; i++) {
        var movie = Movie.fromJSON(res.results[i]);
        listMovie.add(movie);
      }

      return listMovie;

    } else {
      throw Exception('Failed to load photos');
    }

  }

  

}




