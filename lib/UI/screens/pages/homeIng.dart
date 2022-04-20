import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';

class HomeAgent extends StatefulWidget {
  const HomeAgent({Key? key}) : super(key: key);

  @override
  State<HomeAgent> createState() => _HomeAgentState();
}

class _HomeAgentState extends State<HomeAgent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBack,
      ),
    );
  }
}
