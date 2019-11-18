import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondScreenState();
  }
}

class _SecondScreenState extends State<SecondScreen> {
  double height = 100.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterBuild);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second screen"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                left: 0,
                bottom: 0,
                right: 0,
                height: height,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  color: Colors.blue,
                  constraints: BoxConstraints.expand(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _afterBuild(Duration timeStamp) {
    setState(() {
      height = 500;
    });
  }
}
