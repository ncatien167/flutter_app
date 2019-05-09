import 'package:flutter/material.dart';
import 'repository/listMovie_repository.dart';
import 'Models/ListMovie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/zoomable.dart';
import 'MovieDetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  Response data;
  int page = 1;

  List<ListMoive> listMovie = List<ListMoive>();
  List<ListMoive> listMovieComingSoon = List<ListMoive>();
  Future<List<ListMoive>> movies;

  final ScrollController scrollController = new ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getListMoiveComingSoon();
    getListMoivePopular();
    movies = MovieDBApi().getListMovie('1');
    print(movies);
  }

  @override
  Widget build(BuildContext context) {

    final gridMovies = new GridView.builder(
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
          onTap: () {
            _onTapLogin(context);
          },
        );
      },
    );

    final refreshIndicator = new RefreshIndicator(
      key: refreshKey,
      child: gridMovies,
      onRefresh: refreshList,
    );

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
          child: refreshIndicator,
        ),
      ),
    );
  }

  Future<List<ListMoive>> getListMoivePopular() async {
    final response = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=$page');
    if (response.statusCode == 200) {
      Map dataRes = jsonDecode(response.body);
      var res = new Response.fromJSON(dataRes);

      setState(() {
        for (var i = 0; i<res.results.length; i++) {
          var movie = ListMoive.fromJSON(res.results[i]);
          listMovie.add(movie);
        }
      });
      return listMovie;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<ListMoive>> getListMoiveComingSoon() async {
    final response = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=ee8cf966d22254270f6faa1948ecf3fc&language=en-US&page=$page');
    if (response.statusCode == 200) {
      Map dataRes = jsonDecode(response.body);
      var res = new Response.fromJSON(dataRes);

      setState(() {
        for (var i = 0; i<res.results.length; i++) {
          var movie = ListMoive.fromJSON(res.results[i]);
          listMovieComingSoon.add(movie);
        }
      });

      return listMovieComingSoon;
    } else {
      throw Exception('Failed to load photos');
    }
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
            child: TransitionToImage(image: AdvancedNetworkImage(
              'https://image.tmdb.org/t/p/w500' + listMovie[index].posterPath,
            )),
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    refresh();
    return null;
  }

  void loadMore() {
    page += 1;
    print('Page number: $page');
    print('Number Item: ${listMovie.length}');
    getListMoivePopular();
  }

  void refresh() {
    page = 1;
    listMovie.clear();
    getListMoivePopular();
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

  void _onTapLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return MovieDetailPage();
    }));
  }

}