import 'package:flutter/material.dart';
import 'repository/listMovie_repository.dart';
import 'Models/ListMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  Response data;
  List<ListMoive> listMovie = List<ListMoive>();
  int page = 1;
  final ScrollController scrollController = new ScrollController();

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
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              loadMore();
            }
          },
            child: GridView.builder(
              itemCount: listMovie.length,
              primary: true,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 500 / 750,
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  child: new Card(
                    color: Colors.black,
                    elevation: 0.0,
                    child: _itemWidget(index),
                  ),
                );
              },
            )
        ),
      ),
    );
  }

  Widget _itemWidget(index) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.green,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45
                ],
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500' + listMovie[index].posterPath,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45
                ],
              ),
            ),
            child: Text(
              listMovie[index].title,
              textAlign: TextAlign.left,
              style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void listenForMovies() async {
    final String url = 'https://api.themoviedb.org/3/movie/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=$page';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map dataRes = jsonDecode(response.body);
      var res = new Response.fromJSON(dataRes);

      setState(() {
        for (var i = 0; i<res.results.length; i++) {
          var movie = ListMoive.fromJSON(res.results[i]);
          listMovie.add(movie);
        }
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  void loadMore() {
    page += 1;
    print('Page number: $page');
    print('Number Item: ${listMovie.length}');
    listenForMovies();
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        loadMore();
      }
    }
    return true;
  }

}