import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/ListMovie.dart';
import '../Configs/Constant.dart';

Future<Stream<Response>> getListMovie() async {
  final String url = 'https://api.themoviedb.org/3/movie/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=1';

  final client = new http.Client();
  final streamRest = await client.send(
    http.Request('get', Uri.parse(url))
  );

  return streamRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data))
      .map((data) => Response.fromJSON(data));
}