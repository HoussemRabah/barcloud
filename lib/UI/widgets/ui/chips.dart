import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class ChipsLine extends StatefulWidget {
  final List<String> data;
  final Function todo;
  const ChipsLine({Key? key, required this.data, required this.todo})
      : super(key: key);

  @override
  State<ChipsLine> createState() => _ChipsLineState();
}

String _selectedItem = "tous";

class _ChipsLineState extends State<ChipsLine> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.todo();
              _selectedItem = "tous";
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: radius,
                  color: (_selectedItem == "tous") ? colorPrime : colorMain),
              margin: EdgeInsets.all(4.0),
              padding: EdgeInsets.all(4.0),
              child: Text(
                "tous",
                style: styleSmall.copyWith(
                    color: (_selectedItem == "tous") ? colorMain : colorFront),
              ),
            ),
          ),
          for (String item in widget.data)
            GestureDetector(
              onTap: () {
                widget.todo();
                _selectedItem = item;
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: radius,
                    color: (_selectedItem == item) ? colorPrime : colorMain),
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                child: Text(
                  item,
                  style: styleSmall.copyWith(
                      color: (_selectedItem == item) ? colorMain : colorFront),
                ),
              ),
            )
        ],
      ),
    );
  }
}
