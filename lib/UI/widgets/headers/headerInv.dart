import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class HeaderInv extends StatefulWidget {
  final int zonesAvailble;
  const HeaderInv({Key? key, required this.zonesAvailble}) : super(key: key);

  @override
  State<HeaderInv> createState() => _HeaderInvState();
}

class _HeaderInvState extends State<HeaderInv> {
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
        child: Center(
          child: Text(
            "${widget.zonesAvailble} zones d'inventaires disponible pour vous",
            style: styleSimplePlus.copyWith(color: colorMain),
          ),
        ));
  }
}
