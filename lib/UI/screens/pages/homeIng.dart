import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class HomeIng extends StatefulWidget {
  const HomeIng({Key? key}) : super(key: key);

  @override
  State<HomeIng> createState() => _HomeIngState();
}

class _HomeIngState extends State<HomeIng> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBack,
      ),
    );
  }
}
