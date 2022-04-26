import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/constants.dart';

class TitleLine extends StatefulWidget {
  final String title;
  final Function? todo;
  const TitleLine({Key? key, required this.title, this.todo}) : super(key: key);

  @override
  State<TitleLine> createState() => _TitleLineState();
}

class _TitleLineState extends State<TitleLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: styleSimplePlus.copyWith(color: colorAccent),
          ),
        ),
        if (widget.todo != null) Spacer(),
        if (widget.todo != null)
          GestureDetector(
              onTap: (widget.todo != null)
                  ? () {
                      widget.todo!();
                    }
                  : () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "afficher plus",
                  style: styleSmall.copyWith(color: colorAccent),
                ),
              ))
      ],
    );
  }
}
