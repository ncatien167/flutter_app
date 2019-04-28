import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyHomePage(title: 'LOGIN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    final loginIcon = new Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Container(
        child: FlutterLogo(),
        width: 100,
        height: 100,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black38),),
    );

    final loginTitle = new Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
      child: Text(
        "Hello, \nWelcome back",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );

    final emailTextField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordTextField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      )
    );

    return Scaffold(
      body: SafeArea(
          top: true,
          child: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  loginIcon,
                  loginTitle,
                  emailTextField,
                  passwordTextField,
                ],
              ),
            ),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



}
