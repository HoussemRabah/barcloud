import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';

class OptionCard extends StatefulWidget {
  final String image;
  final String title;
  final Function todo;

  const OptionCard({
    Key? key,
    required this.image,
    required this.title,
    required this.todo,
  }) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.todo();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          color: colorMain,
        ),
        width: MediaQuery.of(context).size.width * 0.5 - 8.0 - 4.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            (widget.image.contains(".svg"))
                ? SvgPicture.asset(
                    widget.image,
                    width: 64,
                    height: 64,
                  )
                : Image.asset(
                    widget.image,
                    width: 64,
                    height: 64,
                    fit: BoxFit.scaleDown,
                  ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              widget.title,
              style: styleSimple.copyWith(color: colorAccent),
            ),
          ],
        ),
      ),
    );
  }
}
