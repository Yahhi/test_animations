import 'package:flutter/cupertino.dart';

class ComeFromSidesItem extends StatefulWidget {
  final Widget child;
  final Curve curve;
  final int animationDuration;
  final AnimationSetting animationSetting;

  const ComeFromSidesItem({
    @required this.child,
    @required this.curve,
    @required this.animationDuration,
    @required this.animationSetting,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ComeFromSidesItemState();
  }
}

class _ComeFromSidesItemState extends State<ComeFromSidesItem> {
  double leftPosition;
  double calculatedHeight, calculatedWidth;
  GlobalKey visibilityKey = new GlobalKey();

  @override
  void initState() {
    print("initializing item");
    leftPosition = widget.animationSetting.initialLeft;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(_afterBuild);
  }

  @override
  Widget build(BuildContext context) {
    if (calculatedHeight == null) {
      return Opacity(
        key: visibilityKey,
        opacity: 0,
        child: widget.child,
      );
    } else {
      return Container(
        height: calculatedHeight,
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              left: leftPosition,
              top: 0,
              width: calculatedWidth,
              curve: widget.curve,
              duration: Duration(milliseconds: widget.animationDuration),
              child: widget.child,
            ),
          ],
        ),
      );
    }
  }

  void _afterBuild(Duration timeStamp) {
    print("after build");
    if (calculatedHeight == null) {
      calculatedWidth = visibilityKey.currentContext.size.width;
      setState(() {
        calculatedHeight = visibilityKey.currentContext.size.height;
      });
      print("calculated height became $calculatedHeight");
      print("old position is $leftPosition");
      WidgetsBinding.instance.addPostFrameCallback(_afterBuild);
    } else {
      print("do animation");
      setState(() {
        leftPosition = widget.animationSetting.resultLeft;
      });
      print("new position will be $leftPosition");
    }
  }
}

class AnimationSetting {
  final double initialLeft, initialRight;
  final double resultLeft, resultRight;

  AnimationSetting(
      this.initialLeft, this.initialRight, this.resultLeft, this.resultRight);
}
