import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final String hint;
  const TextFieldInput({Key? key, required this.hint}) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(borderRadius: radius, color: colorAccent),
      child: Container(
        decoration: BoxDecoration(borderRadius: radius, color: colorFront),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: styleSimple.copyWith(color: colorAccent)),
        ),
      ),
    );
  }
}
