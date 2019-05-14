import 'package:flutter/material.dart';
import 'package:flutter_app/Models/ListMovie.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_app/repository/listMovie_repository.dart';
import 'package:flutter_app/screens/feed_detail.dart';

class HomeFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFeedState();
  }
}

class HomeFeedState extends State<HomeFeed> {

  List<Movie> listMovie = List<Movie>();
  
  // ScrollController to check load more
  ScrollController scrollController = new ScrollController();

  // GlobalKey use to show indicator
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  int page = 1;

  @override
  void initState() {
    super.initState();
    getListMovie(false);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Popular'),
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              loadMore();
            }
          },
          child: RefreshIndicator(
            key: refreshKey,
            child: getHomeFeedView(),
            onRefresh: refreshList,
          ),
        ),
      ),
    );
  }

  GridView getHomeFeedView() {
    return GridView.builder(
      itemCount: listMovie.length,
      primary: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 500 / 750,
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 0.0,
            child: gridViewItemWith(index),
          ),
          onTap: () {
            _onTapMovieItem(context, listMovie[index]);
          },
        );
      },
    );
  }

  SizedBox gridViewItemWith(int index) {
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
            child: TransitionToImage(
              image: AdvancedNetworkImage(
                'https://image.tmdb.org/t/p/w500' + listMovie[index].posterPath,
                useDiskCache: true,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
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

  // Refresh handle
  Future<Null> refreshList() async {
    refreshKey.currentState.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    getListMovie(false);
    return null;
  }

  Future<Null> loadMore() {
    page += 1;
    getListMovie(true);
    return null;
  }

  void getListMovie(bool isLoadMore) {
    MovieDBApi().getListMovie('$page').then((value) {
      setState(() {
        if (isLoadMore) {
          listMovie.addAll(value);
        } else {
          listMovie = value;
        }
      });
    });
  }

// Action
  void _onTapMovieItem(BuildContext context, Movie movie) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MovieDetail(movie: movie,)
    ));
  }

}