import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class OptionHor extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function todo;
  const OptionHor(
      {Key? key, required this.icon, required this.title, required this.todo})
      : super(key: key);

  @override
  State<OptionHor> createState() => _OptionHorState();
}

class _OptionHorState extends State<OptionHor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.todo();
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: radius, color: colorMain),
        child: Row(children: [
          Icon(
            widget.icon,
            color: colorPrime,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(widget.title),
        ]),
      ),
    );
  }
}
