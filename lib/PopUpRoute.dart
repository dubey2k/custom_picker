import 'package:custom_picker/PopUpMenu.dart';
import 'package:flutter/material.dart';

class PopUp<T> extends StatefulWidget {
  const PopUp({
    Key? key,
    required this.child,
    required this.content,
    this.contentHeight = 0,
    this.contentWidth,
    this.below,
    this.verticalOffset = 0,
  }) : super(key: key);

  final Widget child;
  final WidgetBuilder content;
  final double contentHeight;
  final double? contentWidth;
  final double verticalOffset;
  final bool? below;

  @override
  PopUpState<T> createState() => PopUpState<T>();
}

class PopUpState<T> extends State<PopUp<T>> {
  PopUpRoute<T>? _dropdownRoute;
  Future<void> openPopup() {
    final NavigatorState navigator = Navigator.of(context);
    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Offset target = itemBox.localToGlobal(
      itemBox.size.center(Offset.zero),
      ancestor: navigator.context.findRenderObject(),
    );
    final Rect itemRect = target & itemBox.size;
    assert(_dropdownRoute == null, 'You can NOT open it twice');
    _dropdownRoute = PopUpRoute<T>(
      width: widget.contentWidth,
      target: target,
      below: widget.below!,
      contentHeight: widget.contentHeight,
      content: widget.content(context),
      buttonRect: itemRect,
      elevation: 4,
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      transitionAnimationDuration: Duration(milliseconds: 500),
      verticalOffset: widget.verticalOffset,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    );

    return navigator.push(_dropdownRoute!).then((T? newValue) {
      removePopUpRoute();
      if (!mounted || newValue == null) return;
    });
  }

  bool get isOpen => _dropdownRoute != null;

  void removePopUpRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
  }

  @override
  void dispose() {
    removePopUpRoute();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class PopUpRoute<T> extends PopupRoute<T> {
  PopUpRoute({
    required this.content,
    required this.contentHeight,
    required this.buttonRect,
    required this.target,
    this.elevation = 8,
    required this.capturedThemes,
    required this.transitionAnimationDuration,
    required this.barrierLabel,
    this.width,
    this.below,
    required this.verticalOffset,
  });

  final Widget content;
  final double contentHeight;
  final Rect buttonRect;
  final int elevation;
  final CapturedThemes capturedThemes;
  final Offset target;
  final double? width;
  final bool? below;
  final double verticalOffset;

  final Duration transitionAnimationDuration;

  @override
  Duration get transitionDuration => transitionAnimationDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(context, animation, secondaryAnimation) {
    return LayoutBuilder(builder: (context, constraints) {
      return _PopUpRoutePage<T>(
        target: target,
        route: this,
        below: below!,
        constraints: constraints,
        content: content,
        buttonRect: buttonRect,
        elevation: elevation,
        width: width,
        capturedThemes: capturedThemes,
        verticalOffset: verticalOffset,
      );
    });
  }

  void _dismiss() {
    if (isActive) {
      navigator?.removeRoute(this);
    }
  }
}

class _PopUpRoutePage<T> extends StatelessWidget {
  const _PopUpRoutePage({
    Key? key,
    required this.route,
    required this.constraints,
    required this.content,
    required this.buttonRect,
    required this.target,
    this.elevation = 8,
    required this.capturedThemes,
    required this.verticalOffset,
    this.style,
    this.below,
    this.width,
  }) : super(key: key);

  final PopUpRoute<T> route;
  final BoxConstraints constraints;
  final Widget content;
  final bool? below;
  final Rect buttonRect;
  final Offset target;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final double? width;
  final double verticalOffset;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    final TextDirection textDirection = TextDirection.ltr;
    final Widget menu = PopUpMenu<T>(
      route: route,
      buttonRect: buttonRect,
      constraints: constraints,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: PopUpMenuRouteLayout<T>(
              target: target,
              below: below!,
              buttonRect: buttonRect,
              route: route,
              textDirection: textDirection,
              verticalOffset: verticalOffset,
              width: width,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}
