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

  List<Movie> listMovie = List<Movie>();
  List<Movie> listMovieComingSoon = List<Movie>();
  Future<List<Movie>> movies;

  final ScrollController scrollController = new ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    MovieDBApi().getListMovie('$page').then((value) {
      setState(() {
        listMovie = value;
      });
    });
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
        backgroundColor: Color(0xFF151026),
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

  Widget _itemWidget(index) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
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
    MovieDBApi().getListMovie('$page').then((value) {
      setState(() {
        listMovie.addAll(value);
      });
    });
  }

  void refresh() {
    page = 1;
    listMovie.clear();
    MovieDBApi().getListMovie('$page').then((value) {
      setState(() {
        listMovie = value;
      });
    });
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