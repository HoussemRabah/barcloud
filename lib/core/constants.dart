import 'package:flutter/material.dart';

Color colorMain = Color(0xFFFFFFFF);
Color colorBack = Color.fromARGB(255, 236, 239, 241);
Color colorFront = Color(0xFF000000);
Color colorPrime = Color(0xFF6399CB);
Color colorAccent = Color(0xFFA6C2DD);
Color colorRed = Color.fromARGB(255, 211, 48, 48);

TextStyle styleTitle = TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900);
TextStyle styleSimplePlus =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500);
TextStyle styleSimple = TextStyle(fontSize: 17.0);
TextStyle styleSmall = TextStyle(fontSize: 14.0);

BorderRadius radius = BorderRadius.all(Radius.circular(30));
BorderRadius radiusHalf = BorderRadius.only(
    topLeft: Radius.circular(30), topRight: Radius.circular(30));
BorderRadius radiusHalfRev = BorderRadius.only(
    bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));
