import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/constants.dart';
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
              clipBehavior: Clip.hardEdge,
              height: 60.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360))),
              child: getImageByType(widget.task.type)),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    8.0 * 2 -
                    8.0 * 2 -
                    60.0 -
                    40.0 -
                    8.0,
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
                    8.0,
                child: Text(
                  "deadline : ${widget.task.deadline.toDate().toString()}",
                  style: styleSmall.copyWith(color: colorAccent),
                ),
              ),
            ],
          ),
          Image.asset(
            "checklist.png",
            fit: BoxFit.scaleDown,
            width: 30,
            height: 30,
          ),
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
      return Text("waiting");

    case TaskProcess.begin:
      return Text("waiting");

    case TaskProcess.end:
      return Text("waiting");

    case TaskProcess.error:
      return Text("waiting");
  }
}
