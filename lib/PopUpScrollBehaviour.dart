
import 'package:flutter/material.dart';

class PopUpScrollBehavior extends ScrollBehavior {
  const PopUpScrollBehavior();

  // @override
  // TargetPlatform getPlatform(BuildContext context) => defaultTargetPlatform;

  @override
  Widget buildViewportChrome(context, child, axisDirection) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

