import 'package:custom_picker/PopUpRoute.dart';
import 'package:custom_picker/PopUpScrollBehaviour.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PopUpMenu<T> extends StatefulWidget {
  const PopUpMenu({
    Key? key,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    this.dropdownColor,
  }) : super(key: key);

  final PopUpRoute<T> route;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final Color? dropdownColor;

  @override
  _PopUpMenuState<T> createState() => _PopUpMenuState<T>();
}

class _PopUpMenuState<T> extends State<PopUpMenu<T>> {
  late CurvedAnimation _fadeOpacity;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation ?? const AlwaysStoppedAnimation<double>(1),
      curve: const Interval(0.0, 0.50),
      reverseCurve: const Interval(0.75, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeOpacity,
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        explicitChildNodes: true,
        child: Material(
          type: MaterialType.transparency,
          child: ScrollConfiguration(
            behavior: const PopUpScrollBehavior(),
            child: widget.route.content,
          ),
        ),
      ),
    );
  }
}

class PopUpMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  PopUpMenuRouteLayout({
    required this.buttonRect,
    required this.route,
    required this.textDirection,
    required this.target,
    required this.verticalOffset,
    this.width,
    this.below = false,
  });

  final Rect buttonRect;
  final PopUpRoute<T> route;
  final TextDirection textDirection;
  final Offset target;
  final bool below;
  final double verticalOffset;
  final double? width;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double maxHeight = constraints.maxHeight;
    final double width =
        this.width ?? math.min(constraints.maxWidth, buttonRect.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      preferBelow: below,
      verticalOffset: verticalOffset,
    );
  }

  @override
  bool shouldRelayout(PopUpMenuRouteLayout<T> oldDelegate) {
    return target != oldDelegate.target || buttonRect != oldDelegate.buttonRect;
  }
}
