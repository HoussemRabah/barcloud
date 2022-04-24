import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/constants.dart';
import '../../../core/sys.dart';
import '../../../modules/class.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: radius,
          color: colorMain,
          boxShadow: [BoxShadow(color: colorAccent)]),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              width: 60.0,
              height: 60.0,
              child: getImageByType(widget.task.type)),
          SizedBox(width: 8.0),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    8.0 * 2 -
                    8.0 * 2 -
                    60.0 -
                    40.0 -
                    8.0 -
                    32.0,
                child: Text(
                  widget.task.title,
                  style: styleSimple,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    8.0 * 2 -
                    8.0 * 2 -
                    60.0 -
                    40.0 -
                    32.0,
                child: Text(
                  "deadline : ${timeToString(widget.task.deadline)}",
                  style: styleSmall.copyWith(color: colorAccent),
                ),
              ),
            ],
          ),
          Spacer(),
          getImageByProcess(widget.task.process),
          Spacer(),
        ],
      ),
    );
  }
}

Widget getImageByType(TaskType type) {
  switch (type) {
    case TaskType.checklist:
      return Image.asset(
        "checklist.png",
        fit: BoxFit.scaleDown,
      );

    case TaskType.add:
      return SvgPicture.asset(
        "additem.svg",
        fit: BoxFit.scaleDown,
      );

    case TaskType.edit:
      return Icon(
        LineIcons.edit,
        color: colorPrime,
      );
  }
}

Widget getImageByProcess(TaskProcess type) {
  switch (type) {
    case TaskProcess.wait:
      return Icon(
        LineIcons.pause,
        color: colorAccent,
        size: 40,
      );

    case TaskProcess.begin:
      return Icon(
        LineIcons.play,
        color: colorPrime,
        size: 40,
      );

    case TaskProcess.end:
      return Icon(
        LineIcons.check,
        color: Colors.green,
        size: 40,
      );

    case TaskProcess.error:
      return Icon(
        LineIcons.exclamation,
        color: Colors.red,
        size: 40,
      );
  }
}
