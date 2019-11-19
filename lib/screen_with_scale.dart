import 'package:flutter/material.dart';

class ScreenWithScale extends StatefulWidget {
  final int animationDuration;
  final Curve curve;

  const ScreenWithScale(
    this.animationDuration,
    this.curve, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenWithScaleState();
  }
}

class _ScreenWithScaleState extends State<ScreenWithScale> {
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
                curve: widget.curve,
                duration: Duration(milliseconds: widget.animationDuration),
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
