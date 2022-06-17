import 'package:barcloud/core/constants.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';

import '../../../modules/class.dart';

class ItemTypeCard extends StatefulWidget {
  final ItemType itemType;
  const ItemTypeCard({Key? key, required this.itemType}) : super(key: key);

  @override
  State<ItemTypeCard> createState() => _ItemTypeCardState();
}

class _ItemTypeCardState extends State<ItemTypeCard> {
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
        widget.itemType.name,
        style: styleSimple,
      ),
    );
  }
}
