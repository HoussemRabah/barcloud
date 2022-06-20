import 'package:barcloud/logic/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/constants.dart';
import '../../../core/sys.dart';
import '../../../modules/class.dart';
import '../../../modules/class.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        decoration: BoxDecoration(
            borderRadius: radius,
            color: colorMain,
            boxShadow: [BoxShadow(color: colorAccent)]),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                width: 60.0, height: 60.0, child: getImageByType(widget.event)),
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
                    widget.event.data,
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
                    "${widget.event.date}",
                    style: styleSmall.copyWith(color: colorAccent),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
                width: 32.0 + 40.0 - 8.0,
                child: getImageByProcess(widget.event)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget getImageByType(Event event) {
  return SizedBox();
}

Widget getImageByProcess(Event event) {
  String text = "";
  if (event.checklistId != null) text = "checklist";
  if (event.taskId != null) text = "tache";
  return Text(
    text,
    style: styleSmall.copyWith(color: colorPrime),
  );
}
