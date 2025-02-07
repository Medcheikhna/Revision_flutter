import 'package:flutter/material.dart';

class MyAnimatedWidget extends ImplicitlyAnimatedWidget {

  final double opacity;

  final Widget child;

  const MyAnimatedWidget({

    super.key,

    required this.opacity,

    required this.child,

    super.duration = const Duration(milliseconds: 300),

    super.curve = Curves.easeInOut,

  });

  @override

  _MyAnimatedWidgetState createState() => _MyAnimatedWidgetState();

}

class _MyAnimatedWidgetState extends AnimatedWidgetBaseState<MyAnimatedWidget> {

  Tween<double>? _opacityTween;

  @override

  void forEachTween(TweenVisitor<dynamic> visitor) {

    _opacityTween = visitor(_opacityTween, widget.opacity, (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;

  }

  @override

  Widget build(BuildContext context) {

    return Opacity(

      opacity: _opacityTween!.evaluate(animation),

      child: widget.child,

    );

  }

}