import 'package:barcloud/UI/screens/pages/login.dart';
import "package:flutter/material.dart";

import '../../../core/constants.dart';

class QrView extends StatefulWidget {
  final String text;
  const QrView({Key? key, required this.text}) : super(key: key);

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      appBar: AppBar(
        backgroundColor: colorPrime,
        elevation: 0.0,
      ),
      body: Center(child: qrRepository.getQRImage(widget.text, 300)),
    );
  }
}
