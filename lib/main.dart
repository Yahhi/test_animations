import 'package:flutter/material.dart';
import 'package:test_animations/second.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Please tap the blue box to see the transition',
              ),
              GestureDetector(
                onTap: _openSecond,
                child: Container(
                  color: Colors.blue,
                  constraints: BoxConstraints.expand(height: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSecond() {
    Navigator.push(context, InvisibleRoute(page: SecondScreen()));
  }
}

class InvisibleRoute extends PageRouteBuilder {
  @override
  Duration get transitionDuration => Duration.zero;

  final Widget page;
  InvisibleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
        );
}
