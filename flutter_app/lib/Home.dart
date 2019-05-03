import 'package:flutter/material.dart';
import 'repository/listMovie_repository.dart';
import 'Models/ListMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  Response data;

  @override
  void initState() {
    super.initState();
        listenForMovies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Text('Item $index'),
                ),
              ),
            );
          },
        )),
    );
  }

  void listenForMovies() async {
    final String url = 'https://api.themoviedb.org/3/movie/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=1';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map dataRes = jsonDecode(response.body);
      var res = new Response.fromJSON(dataRes);
      print('${res}');
    } else {
      throw Exception('Failed to load photos');
    }
  }
  
}