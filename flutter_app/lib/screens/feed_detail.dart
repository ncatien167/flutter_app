import 'package:flutter/material.dart';
import 'package:flutter_app/Models/ListMovie.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class MovieDetail extends StatefulWidget {

  final Movie movie;

  MovieDetail({this.movie});
  
  @override
  State<StatefulWidget> createState() {
    return MovieDetailState(movie);
  }
  
}

class MovieDetailState extends State<MovieDetail> {
  
  MovieDetailState(this.movie);
  final Movie movie;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: ListView(
        children: <Widget>[
          headerContainer(),
          overviewContainer(),
          genreContainer(),
        ],
      ),
    );
  }

  SizedBox headerContainer() {
    return SizedBox(
      height: 400.0,
      child: Stack(
        children: <Widget>[
          imagebackDrop(),
          infoContainer(),
          imagePoster(),
        ],
      ),
    );
  }

  SizedBox imagebackDrop() {
    return SizedBox(
      child: TransitionToImage(
        image: AdvancedNetworkImage(
          'https://image.tmdb.org/t/p/w500' + movie.backdropPath,
          useDiskCache: true,
        ),
      ),
    );
  }

  Container infoContainer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(170, 250, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              movie.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            movie.overview,
            maxLines: 5,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Container imagePoster() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 200, 10, 10),
      child: TransitionToImage(
        image: AdvancedNetworkImage(
          'https://image.tmdb.org/t/p/w500' + movie.posterPath,
          useDiskCache: true,
        ),
      ),
    );
  }

  Container overviewContainer() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Overview',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            movie.overview,
            maxLines: 5,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Container genreContainer() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8, left: 15),
            child: Text(
              'Overview',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: _buildListGenre(),
          ),
        ],
      ),
    ); 
  }

  Widget _buildListGenre() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 150.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TransitionToImage(
                    borderRadius: BorderRadius.all(Radius.circular(70.0)),
                    image: AdvancedNetworkImage(
                      'https://image.tmdb.org/t/p/w500' + movie.posterPath,
                      useDiskCache: true,
                      scale: 10
                    ),
                  ),
                  Container(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              'Overview',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}