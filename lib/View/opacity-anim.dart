import 'package:flutter/material.dart';

class OpacityAnim extends StatefulWidget {
  const OpacityAnim({
    super.key,
    required this.OpaA,
    required this.OpaB,
    required this.duration,
    required this.child,
  });

  final Widget child;
  final Duration duration;
  final double OpaA;
  final double OpaB;

  @override
  State<OpacityAnim> createState() => OpacityAnimState();
}

class OpacityAnimState extends State<OpacityAnim> {
  double _opacityA = 0.0;
  double _opacityB = 0.0;
  double _opacity = 0.0;

  Duration _duration = Duration.zero;

  void playAnim() {
    setState(() {
      _opacity = _opacityB;
    });
  }

  void playAnimReverse() {
    setState(() {
      _opacity = _opacityA;
    });
  }

  @override
  void initState() {
    super.initState();
    _opacityA = widget.OpaA;
    _opacityB = widget.OpaB;
    _duration = widget.duration;

    // Start from A
    _opacity = _opacityA;

    // Call your function AFTER first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playAnim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _duration,
      child: widget.child,
    );
  }
}
