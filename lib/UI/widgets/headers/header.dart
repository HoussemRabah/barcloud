import 'package:barcloud/core/constants.dart';
import 'package:barcloud/modules/class.dart';
import 'package:flutter/material.dart';

import '../../../logic/bloc/auth/auth_bloc.dart';

class HeaderUser extends StatefulWidget {
  final TheUser user;
  const HeaderUser({Key? key, required this.user}) : super(key: key);

  @override
  State<HeaderUser> createState() => _HeaderUserState();
}

class _HeaderUserState extends State<HeaderUser> {
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
        child: Column(
          children: [
            Spacer(),
            Row(children: [
              Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(360))),
                  child: FutureBuilder(
                    future: widget.user.getImage(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) if (snapshot.data != null)
                        return Image.network(
                          snapshot.data!,
                          loadingBuilder: (context, child, loadingProgress) =>
                              CircularProgressIndicator(),
                        );
                      return CircularProgressIndicator();
                    },
                  )),
              SizedBox(
                width: 8.0,
              ),
              Column(
                children: [
                  Text(
                    widget.user.getFullName(),
                    style: styleSimplePlus.copyWith(color: colorMain),
                  ),
                  Text(
                    widget.user.sub,
                    style: styleSmall.copyWith(color: colorMain),
                  ),
                ],
              )
            ]),
          ],
        ));
  }
}
