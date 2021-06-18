import 'package:flutter/material.dart';

class YesNoPickerControl extends StatelessWidget {
  const YesNoPickerControl({
    Key? key,
    required this.onChanged,
    required this.onCancel,
    this.color = const Color(0xFFB9B6B6),
  }) : super(key: key);

  final VoidCallback onChanged;
  final VoidCallback onCancel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: MaterialButton(
              child: Icon(
                Icons.check,
                color: color,
              ),
              onPressed: onChanged,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: MaterialButton(
              child: Icon(
                Icons.close,
                color: color,
              ),
              onPressed: onCancel,
            ),
          ),
        ),
      ],
    );
  }
}
