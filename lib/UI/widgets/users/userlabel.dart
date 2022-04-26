import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

import '../images/imagecircle.dart';

class UserLabel extends StatefulWidget {
  final String username;
  final Future<String> image;
  final String sub;
  const UserLabel(
      {Key? key,
      required this.username,
      required this.image,
      required this.sub})
      : super(key: key);

  @override
  State<UserLabel> createState() => _UserLabelState();
}

class _UserLabelState extends State<UserLabel> {
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageCircle(img: widget.image),
          SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    8.0 -
                    8.0 -
                    60.0 -
                    8.0 -
                    8.0,
                child: Text(
                  "${widget.username}",
                  style: styleSimplePlus.copyWith(color: colorMain),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width -
                    8.0 -
                    8.0 -
                    60.0 -
                    8.0 -
                    8.0,
                child: Text(
                  widget.sub,
                  style: styleSmall.copyWith(color: colorMain),
                ),
              ),
            ],
          )
        ]);
  }
}
