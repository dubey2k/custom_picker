library custom_picker;

import 'package:custom_picker/CustomPickerContentPopUp.dart';
import 'package:custom_picker/PopUpRoute.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPicker extends StatefulWidget {
  const CustomPicker({
    Key? key,
    required this.selected,
    required this.onChanged,
    this.handleChange,
    this.onCancel,
    this.verticalOffset = 0,
    this.below = true,
    required this.list,
    this.optionLoop,
    this.contentPadding = const EdgeInsets.all(0),
    this.popupHeight = 400,
    this.divColor = const Color(0xFFB9B6B6),
    this.wtList = const [1, 1, 1],
    this.widDecoration = const BoxDecoration(),
    this.childDecoration = const [],
    this.widHeight = 40,
    this.yesNo = false,
    this.popUpMargin,
    this.popUpSelColor,
    this.popUpDecoration,
  }) : assert((list.length == selected.length &&
                selected.length == childDecoration.length) ||
            (list.length == selected.length &&
                (childDecoration == null || childDecoration.length == 0)));

  /// give a decoration to your popupDecpration
  final Decoration? popUpDecoration;

  /// vertical position of popup widget
  final double verticalOffset;

  /// show popup widget below the [CustomPicker]
  final bool below;

  /// The current selected list.
  final List<int> selected;

  /// whether to show yes no dialog
  final bool yesNo;

  /// Whenever the current date is changed. If this is null, the picker is considered disabled
  final ValueChanged<List<int>> onChanged;

  /// any change in any child will call this method
  final ValueChanged<List<int>>? handleChange;

  /// Margin for PopUp Widget (if it is zero, pop up widget will be visible at the center of picker)
  final EdgeInsets? popUpMargin;

  /// Whenever the user cancels when changing the date.
  final VoidCallback? onCancel;

  ///List<List<dynamic>> List of Lists of Options to be displayed on pop up widget
  final List<List<dynamic>> list;

  ///List<int> flex propertry of visible widget items
  final List<int> wtList;

  /// The padding of the picker
  final EdgeInsetsGeometry contentPadding;

  ///BoxDecoration for visible widget
  final BoxDecoration widDecoration;

  ///BoxDecoration for visible widget's child
  final List<BoxDecoration> childDecoration;

  ///height for visible widget
  final double widHeight;

  /// The height of the popup
  final double popupHeight;

  /// Divider Color for visible Widget
  final Color divColor;

  /// PopUp Selected Item Color
  final Color? popUpSelColor;

  ///List<bool> which child to loop over wheel
  final List<bool>? optionLoop;

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  List<int> sel = [];
  final popupKey = GlobalKey<PopUpState>();
  List<FixedExtentScrollController>? controllers = [];

  @override
  void initState() {
    super.initState();
    widget.selected.forEach((e) => sel.add(e));
    initControllers();
  }

  void initControllers() {
    for (int i = 0; i < widget.list.length; i++) {
      controllers?.add(
        FixedExtentScrollController(
          initialItem: sel[i],
        ),
      );
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.list.length; i++) {
      controllers?[i].dispose();
      controllers = null;
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool isTrue = false;
    if (sel.length == widget.selected.length) {
      for (int i = 0; i < widget.selected.length; i++) {
        if (widget.selected[i] != sel[i]) {
          isTrue = true;
        }
      }
    } else {
      isTrue = true;
    }
    if (isTrue) {
      sel.clear();
      widget.selected.forEach((e) => sel.add(e));
      for (int i = 0; i < widget.list.length; i++) {
        controllers?[i].jumpToItem(sel[i]);
      }
    }
  }

  Future<void> handleDataChanged(List<int> list) async {
    widget.handleChange?.call(list);
  }

  @override
  Widget build(BuildContext context) {
    Widget picker = MaterialButton(
        onPressed: () async {
          await popupKey.currentState?.openPopup();
          for (int i = 0; i < widget.list.length; i++) {
            controllers?[i].dispose();
          }
          controllers = [];
          initControllers();
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 700),
            decoration: widget.widDecoration,
            curve: Curves.bounceIn,
            height: widget.widHeight,
            child: Row(
              children: List.generate(
                widget.list.length,
                (index) {
                  return Expanded(
                    flex: widget.wtList[index],
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              decoration: widget.childDecoration != null &&
                                      widget.childDecoration.length > 0
                                  ? widget.childDecoration[index]
                                  : BoxDecoration(),
                              padding: widget.contentPadding,
                              child: Text(
                                  '${widget.list[index][widget.selected[index]]}'),
                            ),
                          ),
                        ),
                        index != widget.list.length - 1
                            ? VerticalDivider(
                                color: widget.divColor,
                                thickness: 2,
                                width: 0,
                              )
                            : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            )));
    picker = PopUp(
      contentHeight: widget.popupHeight,
      key: popupKey,
      child: picker,
      below: widget.below,
      verticalOffset: widget.verticalOffset,
      content: (context) => CustomPickerContentPopUp(
        popUpMargin: widget.popUpMargin,
        popUpSelColor: widget.popUpSelColor,
        height: widget.popupHeight,
        popUpDecoration: widget.popUpDecoration,
        selected: sel,
        data: widget.list,
        optionLoop: widget.optionLoop,
        controllers: controllers!,
        yesNo: widget.yesNo,
        handleChanged: handleDataChanged,
        onCancel: () => widget.onCancel?.call(),
        onChanged: () => widget.onChanged.call(sel),
      ),
    );
    return picker;
  }
}
