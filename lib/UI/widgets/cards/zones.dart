import 'package:barcloud/core/constants.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';

class ZoneCard extends StatefulWidget {
  final Zone zone;
  const ZoneCard({Key? key, required this.zone}) : super(key: key);

  @override
  State<ZoneCard> createState() => _ZoneCardState();
}

class _ZoneCardState extends State<ZoneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorMain, borderRadius: radius),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            widget.zone.name,
            style: styleSimple,
          ),
        ],
      ),
    );
  }
}
