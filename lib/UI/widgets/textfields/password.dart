import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/constants.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({Key? key}) : super(key: key);

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

bool _dontSeePassword = true;

class _TextFieldPasswordState extends State<TextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(borderRadius: radius, color: colorAccent),
      child: Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(borderRadius: radius, color: colorMain),
        child: TextField(
          obscureText: _dontSeePassword,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _dontSeePassword = !_dontSeePassword;
                  });
                },
                child: Icon(
                  _dontSeePassword ? LineIcons.eye : LineIcons.eyeSlash,
                  color: colorPrime,
                ),
              ),
              border: InputBorder.none,
              hintText: "mot de passe",
              hintStyle: styleSimple.copyWith(color: colorAccent)),
        ),
      ),
    );
  }
}
