import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_animations/come_from_side_item.dart';

class ComeFromSidesScreen extends StatefulWidget {
  final int animationDuration;
  final Curve curve;

  const ComeFromSidesScreen(
    this.animationDuration,
    this.curve, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ComeFromSidesScreenState();
  }
}

class _ComeFromSidesScreenState extends State<ComeFromSidesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("chat items"),
      ),
      backgroundColor: Colors.green,
      body: ListView.builder(
        itemBuilder: (BuildContext ctxt, int index) {
          print("index $index");
          if (index % 2 == 0) {
            return ComeFromSidesItem(
              curve: widget.curve,
              animationDuration: widget.animationDuration,
              animationSetting:
                  new AnimationSetting(-screenWidth, 0, 0, screenWidth),
              child: _getRandomItem(true, screenWidth),
            );
          } else {
            return ComeFromSidesItem(
              curve: widget.curve,
              animationDuration: widget.animationDuration,
              animationSetting: new AnimationSetting(
                  screenWidth, screenWidth * 2, 0, screenWidth),
              child: _getRandomItem(false, screenWidth),
            );
          }
        },
      ),
    );
  }

  Widget _getRandomItem(bool isLeft, double width) {
    return Padding(
      padding: EdgeInsets.only(
          left: isLeft ? 0.0 : 20.0, right: isLeft ? 20.0 : 0.0, top: 8.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.blue,
        child: Text(getRandomString()),
      ),
    );
  }

  String getRandomString() {
    int length = Random().nextInt(500);
    return new String.fromCharCodes(
        new List.generate(length, (index) => randomBetween()));
  }

  int randomBetween() {
    const ASCII_START = 65;
    const ASCII_END = 126;
    double randomDouble = Random().nextDouble();
    if (randomDouble < 0) randomDouble *= -1;
    if (randomDouble > 1) randomDouble = 1 / randomDouble;
    return ((ASCII_END - ASCII_START) * Random().nextDouble()).toInt() +
        ASCII_START;
  }
}
