import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class HeaderTasks extends StatefulWidget {
  final int taskFinish;
  final int taskWaiting;
  const HeaderTasks(
      {Key? key, required this.taskFinish, required this.taskWaiting})
      : super(key: key);

  @override
  State<HeaderTasks> createState() => _HeaderTasksState();
}

class _HeaderTasksState extends State<HeaderTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: radiusHalfRev,
          color: colorPrime,
        ),
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "${widget.taskWaiting}",
                    style: styleTitle.copyWith(color: colorMain),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "tâches inachevée",
                    style: styleSmall.copyWith(color: colorMain),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    "${widget.taskFinish}",
                    style: styleTitle.copyWith(color: colorMain),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "tâches accomplies",
                    style: styleSmall.copyWith(color: colorMain),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
