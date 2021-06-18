import 'package:custom_picker/YesNoDialog.dart';
import 'package:flutter/material.dart';

class CustomPickerContentPopUp extends StatefulWidget {
  const CustomPickerContentPopUp({
    Key? key,
    required this.handleChanged,
    required this.onChanged,
    required this.onCancel,
    required this.height,
    required this.selected,
    required this.controllers,
    required this.data,
    this.optionLoop,
    this.yesNo,
    this.popUpMargin,
    this.popUpSelColor,
    this.popUpDecoration,
    this.popUpTextStyle,
  }) : super(key: key);

  final bool? yesNo;
  final List<int> selected;
  final ValueChanged<List<int>> handleChanged;
  final VoidCallback onChanged;
  final VoidCallback onCancel;
  final double height;
  final EdgeInsets? popUpMargin;
  final List<bool>? optionLoop;
  final List<FixedExtentScrollController> controllers;
  final List<List<dynamic>> data;
  final Color? popUpSelColor;
  final Decoration? popUpDecoration;
  final List<TextStyle>? popUpTextStyle;

  @override
  CustomPickerContentPopUpState createState() =>
      CustomPickerContentPopUpState();
}

class CustomPickerContentPopUpState extends State<CustomPickerContentPopUp> {
  @override
  Widget build(BuildContext context) {
    bool loop = (widget.optionLoop != null &&
        widget.optionLoop?.length == widget.selected.length);
    bool style = (widget.popUpTextStyle != null &&
        widget.popUpTextStyle?.length == widget.selected.length);
    final divider = VerticalDivider(
      color: Color(0xFFB9B6B6),
      thickness: 2,
    );
    return Container(
      margin: widget.popUpMargin != null
          ? widget.popUpMargin
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      height: widget.height,
      decoration: widget.popUpDecoration ??
          BoxDecoration(
            color: const Color(0xFFC4C4C4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xFFB9B6B6),
            ),
          ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    color: widget.popUpSelColor ?? Colors.white,
                  ),
                ),
                Row(
                  children: List.generate(
                    widget.data.length,
                    (index) {
                      bool looping = loop ? widget.optionLoop![index] : true;
                      TextStyle styled = style
                          ? widget.popUpTextStyle![index]
                          : TextStyle(fontSize: 17);
                      return Expanded(
                        flex: 2,
                        child: ListWheelScrollView.useDelegate(
                          controller: widget.controllers[index],
                          itemExtent: 40,
                          diameterRatio: 10,
                          renderChildrenOutsideViewport: false,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: looping
                              ? ListWheelChildLoopingListDelegate(
                                  children: List.generate(
                                    widget.data[index].length,
                                    (ind) {
                                      final text = "${widget.data[index][ind]}";
                                      return Center(
                                        child: Text(
                                          text,
                                          style: styled,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : ListWheelChildListDelegate(
                                  children: List.generate(
                                    widget.data[index].length,
                                    (ind) {
                                      final text = "${widget.data[index][ind]}";
                                      return Center(
                                        child: Text(
                                          text,
                                          style: styled,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          onSelectedItemChanged: (change) {
                            widget.selected[index] = change;
                            widget.handleChanged(widget.selected);
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          widget.yesNo!
              ? Divider(
                  color: widget.popUpSelColor ?? Color(0xFFB9B6B6),
                  thickness: 1.5,
                  height: 0,
                )
              : SizedBox(),
          widget.yesNo!
              ? YesNoPickerControl(
                  color: widget.popUpSelColor,
                  onChanged: () {
                    Navigator.pop(context);
                    widget.onChanged.call();
                  },
                  onCancel: () {
                    Navigator.pop(context);
                    widget.onCancel();
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
