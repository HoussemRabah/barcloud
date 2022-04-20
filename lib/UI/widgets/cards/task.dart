import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(borderRadius: radius, color: colorMain),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
              width: 60.0,
              clipBehavior: Clip.hardEdge,
              height: 60.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360))),
              child: Image.asset(
                "checklist.png",
                fit: BoxFit.scaleDown,
              )),
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
                  "deadline : ${widget.task.deadline}",
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
