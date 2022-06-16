import 'package:barcloud/core/constants.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: colorMain,
      ),
      child: Text(
        widget.item.name,
        style: styleSimple,
      ),
    );
  }
}
