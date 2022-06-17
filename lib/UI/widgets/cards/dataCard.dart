import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class DataCard extends StatefulWidget {
  final bool acess;
  final String name;
  final String value;

  const DataCard(
      {Key? key, required this.acess, required this.name, required this.value})
      : super(key: key);

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: radius, color: colorMain),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            widget.name,
            style: styleSimple,
          ),
          Spacer(),
          if (widget.acess)
            Icon(
              Icons.edit,
              color: colorAccent,
            ),
          Text(widget.value),
        ],
      ),
    );
  }
}
