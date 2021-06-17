import 'package:flutter/material.dart';

class YesNoPickerControl extends StatelessWidget {
  const YesNoPickerControl({
    Key ?key,
    required this.onChanged,
    required this.onCancel,
  }) : super(key: key);

  final VoidCallback onChanged;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox(
          height: 50,
          child: MaterialButton(
            child: Icon(Icons.check),
            onPressed: onChanged,
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 50,
          child: MaterialButton(
            child: Icon(Icons.close),
            onPressed: onCancel,
          ),
        ),
      ),
    ]);
  }
}
