import 'package:flutter/material.dart';

class ImageCircle extends StatefulWidget {
  final Future<String> img;
  const ImageCircle({Key? key, required this.img}) : super(key: key);

  @override
  State<ImageCircle> createState() => _ImageCircleState();
}

class _ImageCircleState extends State<ImageCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60.0,
        clipBehavior: Clip.hardEdge,
        height: 60.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(360))),
        child: FutureBuilder(
          future: widget.img,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) if (snapshot.data != null) {
              return Image.network(
                snapshot.data!,
              );
            }
            return Text("loading");
          },
        ));
  }
}
