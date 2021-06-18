import 'package:flutter/material.dart';

class PopUpScrollBehavior extends ScrollBehavior {
  const PopUpScrollBehavior();

  @override
  Widget buildViewportChrome(context, child, axisDirection) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
