import 'package:flutter/material.dart';

class MovieDetailPage extends StatefulWidget {
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();

}

class _MovieDetailPageState extends State<MovieDetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Something'),
        backgroundColor: Color(0xFF151026),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }


}