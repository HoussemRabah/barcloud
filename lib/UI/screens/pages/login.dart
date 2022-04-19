import 'package:barcloud/UI/widgets/textfields/input.dart';
import 'package:barcloud/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBack,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SvgPicture.asset(
                    "assets/shapeBack.svg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "BarCloud",
                          style: styleTitle.copyWith(color: colorPrime),
                        ),
                      ),
                      SizedBox(
                        width: 200.0,
                        child: Text(
                          "Facilitez le travail d'inventaire",
                          style: styleSimplePlus.copyWith(color: colorAccent),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      left: 75.0,
                      top: 120.0,
                      child: Image.asset(
                        "assets/boxes.png",
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 300,
                      )),
                ],
              ),
            ),
            Container(
              color: colorAccent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration:
                    BoxDecoration(borderRadius: radiusHalf, color: colorMain),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8.0),
                      child: TextFieldInput(hint: "email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 8.0),
                      child: TextFieldInput(hint: "password"),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                          borderRadius: radiusHalf, color: colorPrime),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        "Se connecter",
                        style: styleSimplePlus.copyWith(color: colorMain),
                      )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
