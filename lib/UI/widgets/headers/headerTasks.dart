import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class HeaderTasks extends StatefulWidget {
  const HeaderTasks({Key? key}) : super(key: key);

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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "51",
                  style: styleSimplePlus.copyWith(color: colorFront),
                ),
                Text(
                  "tâches inachevée",
                  style: styleSmall.copyWith(color: colorFront),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "51",
                  style: styleSimplePlus.copyWith(color: colorFront),
                ),
                Text(
                  "tâches inachevée",
                  style: styleSmall.copyWith(color: colorFront),
                ),
              ],
            )
          ],
        ));
  }
}
