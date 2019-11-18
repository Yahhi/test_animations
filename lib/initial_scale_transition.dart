import 'package:flutter/material.dart';

class InitialScaleTransition extends StatefulWidget {
  final double delay;
  final Widget child;

  InitialScaleTransition(this.delay, this.child);

  @override
  State<StatefulWidget> createState() {
    return _InitialScaleTransitionState();
  }
}

class _InitialScaleTransitionState extends State<InitialScaleTransition>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..animateTo(300);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnlargingBox(widget.child, controller: _controller);
  }
}

class EnlargingBox extends AnimatedWidget {
  final Widget child;

  const EnlargingBox(this.child, {Key key, AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _progress.value * 2.0,
      child: child,
    );
  }
}
