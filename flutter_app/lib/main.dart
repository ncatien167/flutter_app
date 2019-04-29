import 'package:flutter/material.dart';
import 'Home.dart';
import 'stringExtensions.dart';
import 'package:flutter/services.dart';

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
  String name, email, mobile;
  StringExtensions validateString;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Colors.black, // status bar color
    ));

    final loginIcon = Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: Container(
        child: new Image.asset(
            'images/img_Logo.png',
            width: 167.0,
            height: 147.5,
            fit: BoxFit.fill
        ),
      ),
    );

    final loginTitle = Padding(
      padding: EdgeInsets.fromLTRB(0, 30.0, 0, 50),
      child: Text(
        "Hello, \nWelcome back",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );

    final emailTextField = Padding(
      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
      child: TextField(
          obscureText: true,
          style: style,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            hintText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          )
      ),
    );

    final passwordTextField = Padding(
      padding: EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: TextField(
          obscureText: true,
          style: style,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            hintText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          )
      ),
    );

    final btnLoginButton = SizedBox(
      width: double.infinity,
      height: 40.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0)
        ),
          onPressed: () {
            _onTapLogin(context);
          },
        color: Colors.lightBlue,
        child: Text('LOGIN', style: style),
      ),
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
                  btnLoginButton,
                ],
              ),
            ),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onTapLogin(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

}
